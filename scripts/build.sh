#!/bin/bash

# You must be concerned about security, and your statement is valid—it aims to make the system secure for all users. However, since this is still an alpha version, the priority is to complete the main business flow. Security is relatively easy to implement, but we need to think beyond the business logic itself. We should focus on how to protect the business from vulnerabilities.

# If you're aiming to create a robust, flexible, and scalable platform, security (like a guard, or satpam) should be placed outside the core business processes. Based on this, the easiest way to implement security is by securing the environment where the business operates (i.e., creating a secure environment for business operations without interfering with the business process itself).

# Later, we’ll discuss how dPanel implements security in your workflows.

CURRENT_VERSION=$(cat version)

# Skip build if no changes version
if [[ "${BUILD_DIR}" != "${CURRENT_VERSION}" ]]; then
    echo ">>>>> Installing dependencies <<<<<"
    npm install || exit 2

    # start: build next.js, follow documentation https://nextjs.org/docs/app/api-reference/next-config-js/output
    echo ">>>>> Running Build <<<<<"
    npm run build || exit 2

    echo ">>>>> Copying static and public folders <<<<<"
    cp -r public ${BUILD_DIR}/standalone/ || exit 2
    cp -r ${BUILD_DIR}/static ${BUILD_DIR}/standalone/${BUILD_DIR}/ || exit 2

    echo ">>>>> Create Version Control <<<<<"
    cat version | xargs rm -rf
    echo ${BUILD_DIR} > version
    if [ -d ".next" ]; then
        cp -rf ${BUILD_DIR}/* .next
    else
        cp -rf ${BUILD_DIR} .next
    fi


    echo ">>>>> Cleanup previous version <<<<<"
    # Refetch current version
    NEXT_VERSION=$(cat version)

    # Clean up previous / unused build version. Keep current run and next version (current deployment)
    find ".next/standalone" -name ".build-*" -not -name "${CURRENT_VERSION}" -not -name "${NEXT_VERSION}" -prune -exec rm -rf {} \;
fi

if [[ "${BUILD_DIR}" == "${CURRENT_VERSION}" ]]; then
    echo "Skip build, no changes detected!"
fi