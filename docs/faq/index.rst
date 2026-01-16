.. _faq:

:octicon:`question` FAQ & BEST PRACTICES
========================================

:octicon:`question` FAQ
-----------------------

1. How to integrate needs from an external source?

   - See :ref:`here <external-needs>`.

2. How to link to Jira issues?

   - See :ref:`here <jira>`.

3. How to create a software architecture diagram?

   - See :ref:`here <architecture-diagrams>`.

4. Is Mermaid supported?

   - Yes, see here :need:`ARCH_003`.

5. How to trace source code?

   - See :ref:`here <src-tracing>`.

6. How to build with GitHub Actions and publish to GitHub Pages?

   - See :ref:`here <gh-actions-build>`.

7. Whats the intended use-case of the default need types/directives?

   - The default directives are excellent for understanding the tool's 
     capabilities and for initial feature testing. However, they are intentionally 
     generic. For most real-world projects, especially those adhering to specific 
     standards like ASPICE or ISO 26262 and ISO 21434, we highly recommend defining 
     your own need and link types to align with your internal development processes.

:octicon:`star` BEST PRACTICES
------------------------------

1. Development & Build Environment
    - Use a VSCode devcontainer (see ``.devcontainer/devcontainer.json``).
2. Ecosystem (ubCode, sphinx-needs, sphinx-test-reports, ...) configuration
    - declarative configuration via ``ubproject.toml``.
    - Avoid custom extensions generating needs.json files. If something is missing talk to
       useblocks to get it integrated into the appropriate tool or ecosystem.
    - use ``*.toml`` configuration where possible.
    - avoid jinja templating where possible.
    - use different need types for different purposes and don't distinguish them by tags/attributes/extra_options.
3. External tools
    - Tools contributing needs or anyhing else that is some sort of input for the sphinx Build
      shall run outside/before the actual sphinx build.

      * do not integrate the e.g. static analysis tool into the sphinx build process
      * do not integrate the test execution into the sphinx build process