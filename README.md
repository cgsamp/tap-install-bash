# Tanzu Application Platform Install
## Field script

This repository contains bash scripts that will execute the steps outlined in the [Tanzu documentation](https://docs.vmware.com/en/Tanzu-Application-Platform/1.0/tap/GUID-install-intro.html). Including:
- Update your default kubeconfig
- Deploy Cluster Essentials
- Update local Tanzu CLI
- Add the TAP repository, which stores details about where to find TAP executables
- Deploy TAP
- Create the developer workspace
- Deploy a test workload

## Outcome
At the end of the process, you should have a working TAP deployment with a deployed workload, suitable for exercising the TAP gui, deploying new code, and having fun!

## Prerequisites
- A ready and compliant Kubernetes installation
    - Tested with Azure
    - TODO: Tested with TKGm on vSphere (with kapp version update)
- An available container registry on Azure, GCP, Docker Hub or elsewhere
    - NOTE self-signed certificates are not (yet) supported, so you cannot simply use a lab-deployed container registry.
- Tanzu Network credentials
- Control of a domain's DNS to access the tap-gui and deployed workloads
    - Editing your local HOSTS file works fine
    - Note the ingress IP changes with every TAP redeploy

## Preparation

- Update the tap-values.yaml; example provided
- Place your kubeconfig file in the secrets directory
- Create/update registry_credentials and tanzunet_credentials files
- Edit `hack/tap_deploy.sh` to configure Kubeconfig file location and specific TAP version.
- Download and stage these dependencies in lib
    - tanzu-cluster-essentials-[architecture]-1.0.0.tgz
    - tanzu-framework-[architecture].tar

## Execution
- cd to the hack directory
- make sure permissions are set
    - `chmod 744 ./*.sh`
    - `chmod 744 ./sources/*.sh`
- run `./tap_deploy.sh`
- NOTE the new ingress IP as it scrolls by!
- You will end on a tail of the test application
    - It is complete when you see "Completed initialization in N ms" log message!
    - Ctrl-c to exit the tail

## Post Installation
- You will need to update your DNS or hosts file
    - Mine looks like [screenshot]
    - Retrieve the ingress IP with this command, if you missed it:
        ```
        export INGRESS=$(kubectl get service -n tanzu-system-ingress -o=jsonpath='{.items[?(@.metadata.name=="envoy")].status.loadBalancer.ingress[0].ip}')

        echo $INGRESS
        ```
    - Without updating DNS, you can est your workload with
        ```
        curl --resolve [YOUR DOMAIN]:80:$INGRESS tanzu-java-web-app.default.apps.tap.[YOUR DOMAIN]
        ```

## Results

You should now be able to visit TAP-GUI at the URL you specified in tap-values! The GUI will include the tanzu-java-web-app that was deployed on the cluster. 
- Click on All / tanzu-java-web-app / dependencies to see the resources. 
- Click on the Pod to see runtime details, including Application Live View.
    - Note that this is a _knative scale to zero_ application, so you will need to be curl-ing the app every 60 seconds or so.

## Updating workloads
You should be able to create your own workload and push it!
- Clone tanzu-java-web-app into your own repository
- Run `tanzu apps workload create [your workload]`
- Go to tap-gui and Add your workload (paste in the git path to catalog.yaml)

## Recycling and Troubleshooting

If there are issues, the scripts are / should be idempotent, so you can rerun `tap_deploy.sh` repeatedly. Edit `tap_deploy.sh` to comment out specific sub-scripts that were successful. Also edit line 2 in each script to `set -eoux pipefail` (adding x) and the scripts will print out all command details.

To tear down the TAP installation, `tap_remove.sh` is provided. Teardown can take a while; you can observe progress by ctrl-c out of the status: Deleting process and run 
```
watch tanzu package installed list -n tap-install
```
