.. _tutorial-licensing-setup:

:octicon:`key` Setting Up ubCode and ubConnect Licenses
=======================================================

This tutorial guides you through configuring licenses for **ubCode** and
**ubConnect**. You'll learn how to set up licenses using configuration
files, environment variables, and how to properly handle licenses in
Docker containers and DevContainers.

.. note::

   **Target audience**: Developers and DevOps engineers who need to
   configure ubCode or ubConnect licenses in development environments,
   CI/CD pipelines, or containerized deployments.

Prerequisites
-------------

Before starting, ensure you have:

* A valid license key and user email from useblocks
* For ubCode: The ubCode VS Code extension installed
* For ubConnect: The ubConnect CLI installed
* (Optional) Docker installed for container-based setups

.. tip::

   **Don't have a license yet?**

   * For **commercial licenses**, contact support@useblocks.com
   * For **open source projects**, ubCode automatically detects public
     repositories with OSI-approved licenses and provides free access

Overview
--------

Both ubCode and ubConnect support two methods for license configuration:

1. **Configuration file** - A TOML file in a platform-specific location
2. **Environment variables** - Override or replace file configuration

Environment variables take precedence over file configuration, making
them ideal for CI/CD pipelines and containerized environments.

.. list-table:: Configuration Summary
   :header-rows: 1
   :widths: 25 40 35

   * - Tool
     - Config File
     - Environment Variables
   * - ubCode
     - ``ubcode.toml``
     - ``UBCODE_LICENSE_KEY``, ``UBCODE_LICENSE_USER``
   * - ubConnect
     - ``ubconnect.toml``
     - ``UBCONNECT_LICENSE_KEY``, ``UBCONNECT_LICENSE_USER``

Method 1: Configuration File Setup
----------------------------------

This method is recommended for individual developer workstations where
the license persists across sessions.

Step 1: Locate Your Configuration Directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The configuration file location varies by operating system:

**For ubCode:**

.. list-table::
   :header-rows: 1
   :widths: 20 80

   * - Platform
     - Configuration Path
   * - Linux
     - ``~/.config/ubcode/ubcode.toml``
   * - macOS
     - ``~/Library/Application Support/ubcode/ubcode.toml``
   * - Windows
     - ``C:\Users\<username>\AppData\Local\useblocks\ubcode\ubcode.toml``

**For ubConnect:**

.. list-table::
   :header-rows: 1
   :widths: 20 80

   * - Platform
     - Configuration Path
   * - Linux
     - ``~/.config/ubconnect/ubconnect.toml``
   * - macOS
     - ``~/Library/Application Support/ubconnect/ubconnect.toml``
   * - Windows
     - ``C:\Users\<username>\AppData\Local\useblocks\ubconnect\ubconnect.toml``

Step 2: Create the Configuration Directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create the directory if it doesn't exist:

**Linux:**

.. code-block:: bash

   # For ubCode
   mkdir -p ~/.config/ubcode

   # For ubConnect
   mkdir -p ~/.config/ubconnect

**macOS:**

.. code-block:: bash

   # For ubCode
   mkdir -p ~/Library/Application\ Support/ubcode

   # For ubConnect
   mkdir -p ~/Library/Application\ Support/ubconnect

**Windows (PowerShell):**

.. code-block:: powershell

   # For ubCode
   New-Item -ItemType Directory -Force -Path "$env:LOCALAPPDATA\useblocks\ubcode"

   # For ubConnect
   New-Item -ItemType Directory -Force -Path "$env:LOCALAPPDATA\useblocks\ubconnect"

Step 3: Create the Configuration File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create the TOML configuration file with your license credentials.

**For ubCode** (``ubcode.toml``):

.. code-block:: toml

   [license]
   key = "AAAAA-BBBBB-CCCCC-DDDDD"
   user = "your.email@example.com"

**For ubConnect** (``ubconnect.toml``):

.. code-block:: toml

   [license]
   key = "AAAAA-BBBBB-CCCCC-DDDDD"
   user = "your.email@example.com"

.. warning::

   Replace the placeholder values with your actual license key and
   email address. The license key format is typically five groups of
   five characters separated by hyphens.

Step 4: Verify the Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**For ubCode:**

1. Open VS Code with the ubCode extension installed
2. Open the Command Palette (``Ctrl+Shift+P`` / ``Cmd+Shift+P``)
3. Run ``ubCode: Restart language server``
4. Check the Output panel (ubCode channel) for license status

**For ubConnect:**

Run ubConnect and check for license validation messages in the output.

Optional: Proxy Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your network requires a proxy for external connections, add a proxy
section to your configuration file:

.. code-block:: toml

   [license]
   key = "AAAAA-BBBBB-CCCCC-DDDDD"
   user = "your.email@example.com"

   [proxy]
   https = "http://proxy.company.com:8080"

.. note::

   Only HTTP CONNECT proxies are supported. System proxies are
   automatically detected when available.

Method 2: Environment Variables
-------------------------------

Environment variables are the recommended approach for:

* CI/CD pipelines
* Docker containers
* Shared development environments
* Temporary or testing configurations

Environment variables **override** any values set in configuration files.

Available Environment Variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**For ubCode:**

.. list-table::
   :header-rows: 1
   :widths: 35 65

   * - Variable
     - Description
   * - ``UBCODE_LICENSE_KEY``
     - Your ubCode license key
   * - ``UBCODE_LICENSE_USER``
     - Email address associated with the license
   * - ``UBCODE_HTTPS_PROXY``
     - Proxy server URL (optional)

**For ubConnect:**

.. list-table::
   :header-rows: 1
   :widths: 35 65

   * - Variable
     - Description
   * - ``UBCONNECT_LICENSE_KEY``
     - Your ubConnect license key
   * - ``UBCONNECT_LICENSE_USER``
     - Email address associated with the license
   * - ``UBCONNECT_HTTPS_PROXY``
     - Proxy server URL (optional)

Setting Environment Variables on Host Systems
---------------------------------------------

Choose the method appropriate for your operating system and use case.

Linux
~~~~~

**Temporary (current session only):**

.. code-block:: bash

   export UBCODE_LICENSE_KEY="AAAAA-BBBBB-CCCCC-DDDDD"
   export UBCODE_LICENSE_USER="your.email@example.com"

**Persistent (recommended locations):**

.. tab-set::

   .. tab-item:: ~/.bashrc (Bash)

      Add to ``~/.bashrc`` for interactive Bash shells:

      .. code-block:: bash

         # ubCode/ubConnect License Configuration
         export UBCODE_LICENSE_KEY="AAAAA-BBBBB-CCCCC-DDDDD"
         export UBCODE_LICENSE_USER="your.email@example.com"

         export UBCONNECT_LICENSE_KEY="AAAAA-BBBBB-CCCCC-DDDDD"
         export UBCONNECT_LICENSE_USER="your.email@example.com"

      Apply changes:

      .. code-block:: bash

         source ~/.bashrc

   .. tab-item:: ~/.profile (Login shells)

      Add to ``~/.profile`` for login shells (applies to all shell types):

      .. code-block:: bash

         # ubCode/ubConnect License Configuration
         export UBCODE_LICENSE_KEY="AAAAA-BBBBB-CCCCC-DDDDD"
         export UBCODE_LICENSE_USER="your.email@example.com"

      Log out and back in, or run:

      .. code-block:: bash

         source ~/.profile

   .. tab-item:: ~/.zshrc (Zsh)

      Add to ``~/.zshrc`` for Zsh shells:

      .. code-block:: bash

         # ubCode/ubConnect License Configuration
         export UBCODE_LICENSE_KEY="AAAAA-BBBBB-CCCCC-DDDDD"
         export UBCODE_LICENSE_USER="your.email@example.com"

      Apply changes:

      .. code-block:: bash

         source ~/.zshrc

   .. tab-item:: /etc/environment (System-wide)

      For system-wide configuration (all users), add to ``/etc/environment``:

      .. code-block:: bash

         UBCODE_LICENSE_KEY="AAAAA-BBBBB-CCCCC-DDDDD"
         UBCODE_LICENSE_USER="your.email@example.com"

      .. warning::

         This makes the license visible to all users on the system.
         Use only in controlled environments.

.. admonition:: Recommendation
   :class: tip

   For personal workstations, use ``~/.bashrc`` or ``~/.zshrc``
   depending on your shell. For servers or shared systems, use
   ``~/.profile`` to ensure the variables are set for all shell types.

macOS
~~~~~

**Temporary (current session only):**

.. code-block:: bash

   export UBCODE_LICENSE_KEY="AAAAA-BBBBB-CCCCC-DDDDD"
   export UBCODE_LICENSE_USER="your.email@example.com"

**Persistent (recommended locations):**

.. tab-set::

   .. tab-item:: ~/.zshrc (Default)

      macOS uses Zsh as the default shell since Catalina. Add to ``~/.zshrc``:

      .. code-block:: bash

         # ubCode/ubConnect License Configuration
         export UBCODE_LICENSE_KEY="AAAAA-BBBBB-CCCCC-DDDDD"
         export UBCODE_LICENSE_USER="your.email@example.com"

      Apply changes:

      .. code-block:: bash

         source ~/.zshrc

   .. tab-item:: ~/.zprofile (Login shells)

      For variables needed by GUI applications launched from Finder:

      .. code-block:: bash

         # ubCode/ubConnect License Configuration
         export UBCODE_LICENSE_KEY="AAAAA-BBBBB-CCCCC-DDDDD"
         export UBCODE_LICENSE_USER="your.email@example.com"

      Log out and back in to apply.

   .. tab-item:: launchctl (GUI apps)

      For environment variables available to all GUI applications:

      .. code-block:: bash

         launchctl setenv UBCODE_LICENSE_KEY "AAAAA-BBBBB-CCCCC-DDDDD"
         launchctl setenv UBCODE_LICENSE_USER "your.email@example.com"

      .. note::

         This method does not persist across reboots. For persistence,
         create a Launch Agent plist file.

.. admonition:: Recommendation
   :class: tip

   For most macOS users, ``~/.zshrc`` is sufficient. If you launch VS
   Code from Finder (not terminal), also add the variables to
   ``~/.zprofile``.

Windows
~~~~~~~

**Temporary (current session only, PowerShell):**

.. code-block:: powershell

   $env:UBCODE_LICENSE_KEY = "AAAAA-BBBBB-CCCCC-DDDDD"
   $env:UBCODE_LICENSE_USER = "your.email@example.com"

**Temporary (current session only, Command Prompt):**

.. code-block:: batch

   set UBCODE_LICENSE_KEY=AAAAA-BBBBB-CCCCC-DDDDD
   set UBCODE_LICENSE_USER=your.email@example.com

**Persistent (recommended methods):**

.. tab-set::

   .. tab-item:: GUI (Recommended)

      1. Press ``Win + R``, type ``sysdm.cpl``, press Enter
      2. Go to the **Advanced** tab
      3. Click **Environment Variables**
      4. Under **User variables**, click **New**
      5. Add each variable:

         * Variable name: ``UBCODE_LICENSE_KEY``
         * Variable value: ``AAAAA-BBBBB-CCCCC-DDDDD``

      6. Repeat for ``UBCODE_LICENSE_USER``
      7. Click **OK** to save
      8. Restart VS Code or any terminal windows

   .. tab-item:: PowerShell

      Set persistent user environment variables via PowerShell:

      .. code-block:: powershell

         [Environment]::SetEnvironmentVariable("UBCODE_LICENSE_KEY", "AAAAA-BBBBB-CCCCC-DDDDD", "User")
         [Environment]::SetEnvironmentVariable("UBCODE_LICENSE_USER", "your.email@example.com", "User")

      Restart your terminal or VS Code to apply.

   .. tab-item:: setx Command

      Use ``setx`` to set persistent user environment variables:

      .. code-block:: batch

         setx UBCODE_LICENSE_KEY "AAAAA-BBBBB-CCCCC-DDDDD"
         setx UBCODE_LICENSE_USER "your.email@example.com"

      .. warning::

         ``setx`` has a 1024 character limit for values. Open a new
         terminal window after running these commands.

.. admonition:: Recommendation
   :class: tip

   For Windows users, the **GUI method** (System Properties) is the
   most reliable for persistent configuration. Use PowerShell's
   ``SetEnvironmentVariable`` for scripted setups.

Docker Container Configuration
------------------------------

This section covers how to configure licenses in Docker containers,
including both standalone containers and DevContainers.

Method A: Environment Variables at Runtime
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Pass environment variables when running the container:

.. code-block:: bash

   docker run -e UBCODE_LICENSE_KEY="AAAAA-BBBBB-CCCCC-DDDDD" \
              -e UBCODE_LICENSE_USER="your.email@example.com" \
              your-image:tag

For Docker Compose, add to your ``docker-compose.yml``:

.. code-block:: yaml

   services:
     dev:
       image: your-image:tag
       environment:
         - UBCODE_LICENSE_KEY=AAAAA-BBBBB-CCCCC-DDDDD
         - UBCODE_LICENSE_USER=your.email@example.com

Method B: Using an Environment File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create a ``.env`` file (do not commit to version control):

.. code-block:: bash

   # .env file - add to .gitignore!
   UBCODE_LICENSE_KEY=AAAAA-BBBBB-CCCCC-DDDDD
   UBCODE_LICENSE_USER=your.email@example.com
   UBCONNECT_LICENSE_KEY=AAAAA-BBBBB-CCCCC-DDDDD
   UBCONNECT_LICENSE_USER=your.email@example.com

**Docker run:**

.. code-block:: bash

   docker run --env-file .env your-image:tag

**Docker Compose:**

.. code-block:: yaml

   services:
     dev:
       image: your-image:tag
       env_file:
         - .env

.. warning::

   **Security Best Practice**: Add ``.env`` to your ``.gitignore`` to
   prevent accidentally committing license credentials:

   .. code-block:: bash

      echo ".env" >> .gitignore

Method C: Mounting the Configuration File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mount the host configuration file into the container:

.. code-block:: bash

   # For ubCode (Linux host)
   docker run -v ~/.config/ubcode/ubcode.toml:/root/.config/ubcode/ubcode.toml:ro \
              your-image:tag

   # For ubConnect (Linux host)
   docker run -v ~/.config/ubconnect/ubconnect.toml:/root/.config/ubconnect/ubconnect.toml:ro \
              your-image:tag

**Docker Compose:**

.. code-block:: yaml

   services:
     dev:
       image: your-image:tag
       volumes:
         # Mount as read-only (:ro) for security
         - ~/.config/ubcode/ubcode.toml:/root/.config/ubcode/ubcode.toml:ro
         - ~/.config/ubconnect/ubconnect.toml:/root/.config/ubconnect/ubconnect.toml:ro

.. note::

   Adjust the container path based on the user running in the
   container. If running as a non-root user, use
   ``/home/<username>/.config/...`` instead of ``/root/.config/...``.

DevContainer Configuration
--------------------------

VS Code DevContainers provide a consistent development environment.
Here's how to configure licenses in DevContainers.

Method A: Using remoteEnv (Recommended)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add environment variables to ``.devcontainer/devcontainer.json``:

.. code-block:: json

   {
     "name": "My DevContainer",
     "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
     "remoteEnv": {
       "UBCODE_LICENSE_KEY": "${localEnv:UBCODE_LICENSE_KEY}",
       "UBCODE_LICENSE_USER": "${localEnv:UBCODE_LICENSE_USER}",
       "UBCONNECT_LICENSE_KEY": "${localEnv:UBCONNECT_LICENSE_KEY}",
       "UBCONNECT_LICENSE_USER": "${localEnv:UBCONNECT_LICENSE_USER}"
     }
   }

This approach:

* Reads variables from your host environment (``localEnv``)
* Passes them to the container as ``remoteEnv``
* Keeps secrets out of version control

.. admonition:: Prerequisite
   :class: important

   Ensure the environment variables are set on your host system first
   (see the host system sections above).

Method B: Using Docker Compose with DevContainers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For complex setups, use Docker Compose with your DevContainer.

Create ``.devcontainer/docker-compose.yml``:

.. code-block:: yaml

   version: '3.8'
   services:
     devcontainer:
       build:
         context: .
         dockerfile: Dockerfile
       volumes:
         - ..:/workspace:cached
       env_file:
         - ../.env.devcontainer
       # Alternatively, use environment directly:
       # environment:
       #   - UBCODE_LICENSE_KEY=${UBCODE_LICENSE_KEY}
       #   - UBCODE_LICENSE_USER=${UBCODE_LICENSE_USER}

Create ``.devcontainer/devcontainer.json``:

.. code-block:: json

   {
     "name": "My DevContainer",
     "dockerComposeFile": "docker-compose.yml",
     "service": "devcontainer",
     "workspaceFolder": "/workspace"
   }

Create ``.env.devcontainer`` (add to ``.gitignore``):

.. code-block:: bash

   UBCODE_LICENSE_KEY=AAAAA-BBBBB-CCCCC-DDDDD
   UBCODE_LICENSE_USER=your.email@example.com

Method C: Mounting Host Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mount the configuration file from the host:

.. code-block:: json

   {
     "name": "My DevContainer",
     "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
     "mounts": [
       {
         "source": "${localEnv:HOME}/.config/ubcode",
         "target": "/home/vscode/.config/ubcode",
         "type": "bind"
       },
       {
         "source": "${localEnv:HOME}/.config/ubconnect",
         "target": "/home/vscode/.config/ubconnect",
         "type": "bind"
       }
     ]
   }

.. note::

   The default user in many DevContainers is ``vscode``, so the target
   path uses ``/home/vscode/...``. Adjust if your container uses a
   different user.

Setting Variables Directly in Container
---------------------------------------

If you need to configure licenses directly inside a running container
(e.g., for debugging or temporary setups):

**Interactive shell:**

.. code-block:: bash

   # Enter the container
   docker exec -it <container_name> /bin/bash

   # Set environment variables for current session
   export UBCODE_LICENSE_KEY="AAAAA-BBBBB-CCCCC-DDDDD"
   export UBCODE_LICENSE_USER="your.email@example.com"

   # Or create the configuration file
   mkdir -p ~/.config/ubcode
   cat > ~/.config/ubcode/ubcode.toml << 'EOF'
   [license]
   key = "AAAAA-BBBBB-CCCCC-DDDDD"
   user = "your.email@example.com"
   EOF

**In Dockerfile (not recommended for secrets):**

.. code-block:: dockerfile

   # NOT RECOMMENDED - exposes secrets in image layers
   ENV UBCODE_LICENSE_KEY="AAAAA-BBBBB-CCCCC-DDDDD"
   ENV UBCODE_LICENSE_USER="your.email@example.com"

.. warning::

   **Never bake license credentials into Docker images.** Environment
   variables set with ``ENV`` in Dockerfiles are visible in image
   metadata and layer history. Always use runtime environment variables
   or mounted secrets.

CI/CD Pipeline Configuration
----------------------------

For CI/CD pipelines, use your platform's secrets management.

GitHub Actions
~~~~~~~~~~~~~~

Store secrets in repository settings, then use them in workflows:

.. code-block:: yaml

   name: Build Documentation
   on: [push, pull_request]

   jobs:
     build:
       runs-on: ubuntu-latest
       env:
         UBCODE_LICENSE_KEY: ${{ secrets.UBCODE_LICENSE_KEY }}
         UBCODE_LICENSE_USER: ${{ secrets.UBCODE_LICENSE_USER }}
         UBCONNECT_LICENSE_KEY: ${{ secrets.UBCONNECT_LICENSE_KEY }}
         UBCONNECT_LICENSE_USER: ${{ secrets.UBCONNECT_LICENSE_USER }}
       steps:
         - uses: actions/checkout@v4
         - name: Build docs
           run: |
             # ubCode/ubConnect will pick up the env vars automatically
             make docs

GitLab CI
~~~~~~~~~

Store secrets in project CI/CD variables, then reference them:

.. code-block:: yaml

   build_docs:
     image: python:3.12
     variables:
       UBCODE_LICENSE_KEY: $UBCODE_LICENSE_KEY
       UBCODE_LICENSE_USER: $UBCODE_LICENSE_USER
     script:
       - pip install ubconnect
       - make docs

Offline License Configuration
-----------------------------

For air-gapped environments without internet access, useblocks provides
offline license files.

Step 1: Request an Offline License
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Contact support@useblocks.com to request an offline activation file.
You'll receive a file named ``ActivationFile.skm``.

Step 2: Configure the Offline License
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Place the activation file in the same directory as your configuration
file and update the configuration:

**For ubCode:**

.. code-block:: toml

   [license]
   file = "ActivationFile.skm"
   user = "your.email@example.com"

**For ubConnect:**

.. code-block:: toml

   [license]
   file = "ActivationFile.skm"
   user = "your.email@example.com"

The final directory structure:

.. code-block:: text

   ~/.config/ubcode/
   ├── ubcode.toml
   └── ActivationFile.skm

License Caching
---------------

Both ubCode and ubConnect cache license validation results locally for
**3 days**. This means:

* The tools work offline for up to 3 days after last validation
* Network issues don't immediately block your work
* License changes may take up to 3 days to take effect

**Cache locations:**

.. list-table::
   :header-rows: 1
   :widths: 20 80

   * - Platform
     - Cache Path
   * - Linux
     - ``~/.cache/ublicense/``
   * - macOS
     - ``~/Library/Caches/ublicense/``
   * - Windows
     - ``%LOCALAPPDATA%\useblocks\ublicense\Cache\``

**To force re-validation**, delete the cache directory:

.. code-block:: bash

   # Linux
   rm -rf ~/.cache/ublicense

   # macOS
   rm -rf ~/Library/Caches/ublicense

   # Windows (PowerShell)
   Remove-Item -Recurse -Force "$env:LOCALAPPDATA\useblocks\ublicense\Cache"

Troubleshooting
---------------

**License not recognized after configuration**

1. Verify the configuration file is in the correct location for your OS
2. Check that the file is valid TOML (use an online TOML validator)
3. For ubCode: Restart the language server (``Ctrl+Shift+P`` →
   ``ubCode: Restart language server``)
4. Try clearing the license cache and restarting

**Environment variables not working**

1. Verify the variables are exported (``echo $UBCODE_LICENSE_KEY``)
2. Ensure you've opened a new terminal after setting persistent variables
3. For VS Code, restart the application completely (not just reload)
4. Check for typos in variable names (they are case-sensitive)

**Proxy issues**

1. Ensure the proxy URL includes the protocol (``http://`` or ``https://``)
2. Only HTTP CONNECT proxies are supported (not SOCKS)
3. Try setting the proxy via environment variable:
   ``export UBCODE_HTTPS_PROXY="http://proxy:8080"``

**Docker container can't validate license**

1. Verify network connectivity from the container
2. Check that environment variables are passed correctly:
   ``docker exec <container> env | grep UBCODE``
3. If using mounted config files, verify the path inside the container
4. Ensure the container user has read permissions on mounted files

**DevContainer not picking up host environment**

1. Verify the variables are set in your host shell
2. If using ``localEnv``, restart VS Code completely
3. Try rebuilding the DevContainer after making changes to
   ``devcontainer.json``

Security Best Practices
-----------------------

1. **Never commit credentials** to version control. Use ``.gitignore``
   to exclude ``.env`` files and configuration directories.

2. **Use secrets management** in CI/CD pipelines rather than hardcoding
   values.

3. **Prefer environment variables** over configuration files in shared
   or automated environments.

4. **Mount config files read-only** (``:ro``) in Docker when possible.

5. **Use user-scoped variables** on Windows rather than system-wide
   when only one user needs access.

6. **Rotate credentials** if you suspect they've been exposed.

Quick Reference
---------------

.. list-table:: Configuration Methods Summary
   :header-rows: 1
   :widths: 25 35 40

   * - Scenario
     - Recommended Method
     - Notes
   * - Personal workstation
     - Configuration file
     - Persists across sessions
   * - CI/CD pipeline
     - Platform secrets + env vars
     - Use GitHub/GitLab secrets
   * - Docker container
     - ``--env-file`` or ``-e`` flags
     - Keep secrets out of images
   * - DevContainer
     - ``remoteEnv`` with ``localEnv``
     - Pulls from host environment
   * - Air-gapped systems
     - Offline license file
     - Contact support for activation file

.. seealso::

   **Official Documentation:**

   * `ubCode License Documentation <https://ubcode.useblocks.com/usage/ublicense.html>`_
   * `ubConnect License Documentation <https://ubconnect.useblocks.com/basics/ublicense.html>`_

   **Related Tutorials:**

   * :ref:`tutorial-sphinx-needs-setup` - Setting up a Sphinx-Needs project
