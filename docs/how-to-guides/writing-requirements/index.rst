.. _how-to-write-requirements:

:octicon:`tasklist` Writing Requirements
========================================

Sphinx-Needs enables your team to create, manage and analyze requirements, 
specifications, test cases, and more inside Sphinx-based documentation.

See the official documentation for more details: `Sphinx-Needs <https://sphinx-needs.readthedocs.io/en/latest/>`_

A need item is a generic object which can become anything you you require for your project: a requirement, a test case, a user story, a bug, an employee, a product...

A basic need item looks like this:

.. req:: Basic need example
    :id: REQ_42

    A basic example of a need item.

.. seealso:: 

   The official `Sphinx-Needs tutorial <https://sphinx-needs.readthedocs.io/en/latest/tutorial.html>`_ is a great starting point to learn more about Sphinx-Needs.

Lets create a second requirement that links to the first one:

.. req:: Requirement linking to another requirement
   :id: REQ_43
   :status: open
   :links: REQ_42

   This is a requirement that links to another requirement via its id and has a status.