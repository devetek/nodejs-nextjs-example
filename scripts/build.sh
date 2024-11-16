#!/bin/bash

# You must be concerned about security, and your statement is valid—it aims to make the system flexible for all users. However, since this is still an alpha version, the priority is to complete the main business flow. Security is relatively easy to implement, but we need to think beyond the business logic itself. We should focus on how to protect the business from vulnerabilities.

# If you're aiming to create a robust, flexible, and scalable platform, security (like a guard, or satpam) should be placed outside the core business processes. Based on this, the easiest way to implement security is by securing the environment where the business operates (i.e., creating a secure environment for business operations without interfering with the business process itself).

# Later, we’ll discuss how dPanel implements security in your workflows.

# Skip build if no changes version
if [[ "$(git rev-parse --short HEAD)" != "$(cat version)" ]]; then
    npm install # install all dependencies
    # start: build next.js, follow documentation https://nextjs.org/docs/app/api-reference/next-config-js/output
    npm run build
    cp -r public ${BUILD_DIR}/standalone/ && cp -r ${BUILD_DIR}/static ${BUILD_DIR}/standalone/${BUILD_DIR}/
    # end: build next.js
    rm -rf .next | echo "folder .next not exist" # delete previous version, pipe to echo to prevent error
    cat version | xargs rm -rf # remove previous version, will never error even if version file does not exist
    echo ${BUILD_DIR} > version # create new version
    cp -rf ${BUILD_DIR} .next # create runtime env (systemd), copy to .next folder
fi