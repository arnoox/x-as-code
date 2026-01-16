.. _tutorial-creating-dashboards:

:octicon:`graph` Creating Powerful Dashboards
=============================================

This tutorial guides you through creating powerful dashboards with
sphinx-needs. By the end, you'll be able to visualize your requirements,
specifications, and test coverage using tables, charts, and flow diagrams.

.. note::

   **Target audience**: Developers familiar with sphinx-needs basics who
   want to create visual dashboards for project status monitoring,
   traceability visualization, and metrics reporting.

Prerequisites
-------------

Before starting, ensure you have:

* A working sphinx-needs project (see :ref:`tutorial-sphinx-needs-setup`)
* Basic understanding of need types and filter expressions
* Optional: Graphviz installed for flow diagrams (``brew install graphviz``
  on macOS or ``apt install graphviz`` on Linux)

What Are Dashboards?
--------------------

Dashboards in sphinx-needs are documentation pages that aggregate and
visualize your needs data. They help you answer questions like:

* What's the status distribution of my requirements?
* Which specifications lack test coverage?
* How do my requirements trace to implementations?
* What's the project timeline?

sphinx-needs provides five main directives for building dashboards:

.. list-table:: Dashboard Directives
   :header-rows: 1
   :widths: 20 40 40

   * - Directive
     - Purpose
     - Best For
   * - ``needtable``
     - Filtered, sortable tables
     - Lists, traceability matrices
   * - ``needpie``
     - Pie charts
     - Status distributions, ratios
   * - ``needbar``
     - Bar charts
     - Comparisons, trends
   * - ``needflow``
     - Flow diagrams
     - Relationships, dependencies
   * - ``needgantt``
     - Gantt charts
     - Timelines, schedules

.. seealso::

   For complete API references, see the official sphinx-needs documentation:

   * `Directives Overview <https://sphinx-needs.readthedocs.io/en/latest/directives/index.html>`_
   * `Filter Expressions <https://sphinx-needs.readthedocs.io/en/latest/filter.html>`_

Setting Up Sample Data
----------------------

To follow along, let's create some sample needs. Add these to a file
called ``sample_needs.rst``:

.. code-block:: rst

   Sample Requirements
   ===================

   .. req:: User Authentication
      :id: REQ_001
      :status: done
      :tags: security, dashboard_demo
      :priority: high

      The system shall authenticate users via username and password.

   .. req:: Password Reset
      :id: REQ_002
      :status: in_progress
      :tags: security, dashboard_demo
      :priority: high

      Users shall be able to reset their password via email.

   .. req:: Session Management
      :id: REQ_003
      :status: open
      :tags: security, dashboard_demo
      :priority: medium

      The system shall manage user sessions with configurable timeout.

   .. spec:: Login API
      :id: SPEC_001
      :status: done
      :tags: api, dashboard_demo
      :links: REQ_001

      POST /api/auth/login accepts username and password.

   .. spec:: Password Reset API
      :id: SPEC_002
      :status: in_progress
      :tags: api, dashboard_demo
      :links: REQ_002

      POST /api/auth/reset-password sends reset email.

   .. test:: Login Success Test
      :id: TEST_001
      :status: done
      :tags: integration, dashboard_demo
      :tests: SPEC_001

      Verify successful login with valid credentials.

   .. test:: Login Failure Test
      :id: TEST_002
      :status: done
      :tags: integration, dashboard_demo
      :tests: SPEC_001

      Verify login fails with invalid credentials.

   .. test:: Password Reset Test
      :id: TEST_003
      :status: open
      :tags: integration, dashboard_demo
      :tests: SPEC_002

      Verify password reset email is sent.

Creating Tables with needtable
------------------------------

The ``needtable`` directive creates filtered, formatted tables from your
needs. It's the most versatile dashboard component.

.. seealso::

   `needtable API Reference <https://sphinx-needs.readthedocs.io/en/latest/directives/needtable.html>`_

Basic Table
~~~~~~~~~~~

Create a simple table showing all requirements:

.. code-block:: rst

   .. needtable:: Requirements Overview
      :filter: type == 'req' and 'dashboard_demo' in tags
      :columns: id; title; status
      :style: table

This produces a table with three columns showing ID, title, and status
for all requirements tagged with ``dashboard_demo``.

Custom Column Titles
~~~~~~~~~~~~~~~~~~~~

Rename columns for better readability:

.. code-block:: rst

   .. needtable:: Requirements Status
      :filter: type == 'req' and 'dashboard_demo' in tags
      :columns: id as "ID"; title as "Requirement"; status as "State"; priority as "Priority"
      :style: table

Column Widths
~~~~~~~~~~~~~

Control column proportions with ``:colwidths:``:

.. code-block:: rst

   .. needtable:: Requirements Matrix
      :filter: type == 'req' and 'dashboard_demo' in tags
      :columns: id; title; status; priority
      :colwidths: 15, 50, 20, 15
      :style: table

Show Applied Filters
~~~~~~~~~~~~~~~~~~~~

Display the filter expression above the table for transparency:

.. code-block:: rst

   .. needtable:: Filtered Requirements
      :filter: type == 'req' and status == 'open'
      :columns: id; title; priority
      :show_filters:
      :style: table

.. tip::

   Use ``:style: datatables`` for interactive tables with sorting and
   searching capabilities (requires the datatables JavaScript library).

Visualizing Status with needpie
-------------------------------

The ``needpie`` directive creates pie charts for visualizing distributions.
Each slice represents the count of needs matching a filter expression.

.. seealso::

   `needpie API Reference <https://sphinx-needs.readthedocs.io/en/latest/directives/needpie.html>`_

Basic Pie Chart
~~~~~~~~~~~~~~~

Show the status distribution of requirements:

.. code-block:: rst

   .. needpie:: Requirements Status
      :labels: Open, In Progress, Done
      :legend:

      type == 'req' and status == 'open' and 'dashboard_demo' in tags
      type == 'req' and status == 'in_progress' and 'dashboard_demo' in tags
      type == 'req' and status == 'done' and 'dashboard_demo' in tags

Each line in the content is a filter expression. The count of matching
needs determines the slice size.

Custom Colors
~~~~~~~~~~~~~

Specify colors using hex values or named colors:

.. code-block:: rst

   .. needpie:: Status Distribution
      :labels: Open, In Progress, Done
      :legend:
      :colors: #ff6b6b, #ffd93d, #6bcb77

      type == 'req' and status == 'open' and 'dashboard_demo' in tags
      type == 'req' and status == 'in_progress' and 'dashboard_demo' in tags
      type == 'req' and status == 'done' and 'dashboard_demo' in tags

Emphasize a Slice
~~~~~~~~~~~~~~~~~

Use ``:explode:`` to highlight specific slices (0-indexed):

.. code-block:: rst

   .. needpie:: Focus on Open Items
      :labels: Open, In Progress, Done
      :legend:
      :colors: #ff6b6b, #ffd93d, #6bcb77
      :explode: 0

      type == 'req' and status == 'open' and 'dashboard_demo' in tags
      type == 'req' and status == 'in_progress' and 'dashboard_demo' in tags
      type == 'req' and status == 'done' and 'dashboard_demo' in tags

Matplotlib Styles
~~~~~~~~~~~~~~~~~

Apply different visual themes:

.. code-block:: rst

   .. needpie:: Dark Theme Status
      :labels: Open, In Progress, Done
      :legend:
      :style: dark_background

      type == 'req' and status == 'open' and 'dashboard_demo' in tags
      type == 'req' and status == 'in_progress' and 'dashboard_demo' in tags
      type == 'req' and status == 'done' and 'dashboard_demo' in tags

Comparing Metrics with needbar
------------------------------

The ``needbar`` directive creates bar charts for comparing values across
categories. It supports both static data and filter-based data.

.. seealso::

   `needbar API Reference <https://sphinx-needs.readthedocs.io/en/latest/directives/needbar.html>`_

Filter-Based Bar Chart
~~~~~~~~~~~~~~~~~~~~~~

Compare status across different need types:

.. code-block:: rst

   .. needbar:: Coverage by Type
      :legend:
      :xlabels: Requirements, Specifications, Tests
      :colors: #6bcb77, #ff6b6b

      Done; type=='req' and status=='done'; type=='spec' and status=='done'; type=='test' and status=='done'
      Open; type=='req' and status!='done'; type=='spec' and status!='done'; type=='test' and status!='done'

Each row defines a data series. The format is:
``Label; filter1; filter2; filter3``

Stacked Bar Chart
~~~~~~~~~~~~~~~~~

Stack bars to show totals:

.. code-block:: rst

   .. needbar:: Stacked Status
      :legend:
      :xlabels: Requirements, Specifications, Tests
      :stacked:
      :colors: #6bcb77, #ffd93d, #ff6b6b

      Done; type=='req' and status=='done'; type=='spec' and status=='done'; type=='test' and status=='done'
      In Progress; type=='req' and status=='in_progress'; type=='spec' and status=='in_progress'; type=='test' and status=='in_progress'
      Open; type=='req' and status=='open'; type=='spec' and status=='open'; type=='test' and status=='open'

Horizontal Bar Chart
~~~~~~~~~~~~~~~~~~~~

Display bars horizontally for better label readability:

.. code-block:: rst

   .. needbar:: Horizontal Status
      :legend:
      :xlabels: Requirements, Specifications, Tests
      :horizontal:
      :colors: #6bcb77, #ff6b6b

      Done; type=='req' and status=='done'; type=='spec' and status=='done'; type=='test' and status=='done'
      Open; type=='req' and status!='done'; type=='spec' and status!='done'; type=='test' and status!='done'

Axis Titles and Styling
~~~~~~~~~~~~~~~~~~~~~~~

Customize the chart appearance:

.. code-block:: rst

   .. needbar:: Detailed Chart
      :legend:
      :xlabels: Req, Spec, Test
      :x_axis_title: Need Types
      :y_axis_title: Count
      :xlabels_rotation: 45
      :style: ggplot

      Completed; type=='req' and status=='done'; type=='spec' and status=='done'; type=='test' and status=='done'

Static Data
~~~~~~~~~~~

You can also use static numbers instead of filters:

.. code-block:: rst

   .. needbar:: Sprint Progress
      :legend:
      :xlabels: Sprint 1, Sprint 2, Sprint 3

      Planned; 10; 12; 8
      Completed; 10; 11; 5

Showing Relationships with needflow
-----------------------------------

The ``needflow`` directive creates flow diagrams showing relationships
between needs. It's essential for visualizing traceability.

.. seealso::

   `needflow API Reference <https://sphinx-needs.readthedocs.io/en/latest/directives/needflow.html>`_

Basic Flow Diagram
~~~~~~~~~~~~~~~~~~

Show all needs with a specific tag:

.. code-block:: rst

   .. needflow:: Traceability
      :filter: 'dashboard_demo' in tags

Filter by Link Types
~~~~~~~~~~~~~~~~~~~~

Show only specific relationship types:

.. code-block:: rst

   .. needflow:: Test Coverage
      :filter: 'dashboard_demo' in tags
      :link_types: tests

Show Link Names
~~~~~~~~~~~~~~~

Display the relationship type on arrows:

.. code-block:: rst

   .. needflow:: Detailed Traceability
      :filter: 'dashboard_demo' in tags
      :link_types: tests, links
      :show_link_names:

Using Graphviz Engine
~~~~~~~~~~~~~~~~~~~~~

For complex diagrams, use the Graphviz engine:

.. code-block:: rst

   .. needflow:: Graphviz Flow
      :filter: 'dashboard_demo' in tags
      :engine: graphviz
      :link_types: tests, links
      :show_link_names:

.. note::

   The Graphviz engine requires Graphviz to be installed on your system.
   Install it via ``brew install graphviz`` (macOS) or
   ``apt install graphviz`` (Linux).

Configuration Presets
~~~~~~~~~~~~~~~~~~~~~

Apply predefined styles:

.. code-block:: rst

   .. needflow:: Monochrome Flow
      :filter: 'dashboard_demo' in tags
      :config: monochrome

   .. needflow:: Left to Right Flow
      :filter: 'dashboard_demo' in tags
      :config: lefttoright

Timeline Views with needgantt
-----------------------------

The ``needgantt`` directive creates Gantt charts for timeline visualization.
Needs must have duration information to appear in the chart.

.. seealso::

   `needgantt API Reference <https://sphinx-needs.readthedocs.io/en/latest/directives/needgantt.html>`_

Adding Duration to Needs
~~~~~~~~~~~~~~~~~~~~~~~~

First, ensure your needs have duration data:

.. code-block:: rst

   .. req:: Feature Development
      :id: REQ_GANTT_001
      :status: in_progress
      :duration: 5
      :tags: gantt_demo

      Implement the core feature.

   .. spec:: API Design
      :id: SPEC_GANTT_001
      :status: done
      :duration: 2
      :tags: gantt_demo
      :links: REQ_GANTT_001

      Design the REST API endpoints.

   .. test:: Integration Tests
      :id: TEST_GANTT_001
      :status: open
      :duration: 3
      :tags: gantt_demo
      :tests: SPEC_GANTT_001

      Write integration tests.

Basic Gantt Chart
~~~~~~~~~~~~~~~~~

Create a timeline from filtered needs:

.. code-block:: rst

   .. needgantt:: Project Timeline
      :filter: 'gantt_demo' in tags

Milestones
~~~~~~~~~~

Highlight key milestones:

.. code-block:: rst

   .. needgantt:: Timeline with Milestones
      :filter: 'gantt_demo' in tags
      :milestone_filter: status == 'done'

Building a Complete Dashboard
-----------------------------

Now let's combine everything into a comprehensive dashboard page.
Create a file called ``dashboard.rst``:

.. code-block:: rst

   Project Dashboard
   =================

   This dashboard provides an overview of the project status.

   Status Overview
   ---------------

   .. needpie:: Requirements Status
      :labels: Open, In Progress, Done
      :legend:
      :colors: #ff6b6b, #ffd93d, #6bcb77

      type == 'req' and status == 'open'
      type == 'req' and status == 'in_progress'
      type == 'req' and status == 'done'

   Coverage by Type
   ----------------

   .. needbar:: Status by Type
      :legend:
      :xlabels: Requirements, Specifications, Tests
      :stacked:
      :colors: #6bcb77, #ffd93d, #ff6b6b

      Done; type=='req' and status=='done'; type=='spec' and status=='done'; type=='test' and status=='done'
      In Progress; type=='req' and status=='in_progress'; type=='spec' and status=='in_progress'; type=='test' and status=='in_progress'
      Open; type=='req' and status=='open'; type=='spec' and status=='open'; type=='test' and status=='open'

   Requirements List
   -----------------

   .. needtable:: All Requirements
      :filter: type == 'req'
      :columns: id as "ID"; title as "Requirement"; status as "Status"; priority as "Priority"
      :colwidths: 15, 50, 20, 15
      :style: table

   Traceability
   ------------

   .. needflow:: Full Traceability
      :link_types: tests, links
      :show_link_names:

Tips and Best Practices
-----------------------

Performance
~~~~~~~~~~~

* Use specific filters to limit the data processed
* Avoid ``needflow`` with too many nodes (>50 can be slow)
* Consider splitting large dashboards into multiple pages

Consistent Styling
~~~~~~~~~~~~~~~~~~

Define a color scheme and use it consistently:

.. code-block:: rst

   .. note::

      **Color Legend:**

      * Green (#6bcb77): Done/Passed
      * Yellow (#ffd93d): In Progress/Warning
      * Red (#ff6b6b): Open/Failed/Blocked

Reusable Filters
~~~~~~~~~~~~~~~~

Create filter patterns you can reuse using `needs_filter_data <https://sphinx-needs.readthedocs.io/en/latest/configuration.html#needs-filter-data>`_:

.. code-block:: python

   # In conf.py
   needs_filter_data = {
       'current_sprint': "tags and 'sprint-5' in tags",
       'security_items': "tags and 'security' in tags",
   }

Then use in your dashboards:

.. code-block:: rst

   .. needtable:: Sprint Items
      :filter: current_sprint
      :columns: id; title; status

Accessibility
~~~~~~~~~~~~~

* Always include legends for charts
* Use distinct colors (consider colorblind-friendly palettes)
* Provide alternative text in table captions

Limitations and Advanced Solutions
----------------------------------

.. note::

   **Dashboard History Limitation**

   sphinx-needs provides point-in-time dashboards - snapshots of your current
   project state. It does not include built-in history or trending capabilities
   to answer questions like:

   * How has test coverage changed over the last month?
   * What was the status distribution two sprints ago?
   * Are we closing requirements faster than we're opening them?

   For historical tracking, trend analysis, and time-based comparisons,
   **ubTrace** from useblocks is the recommended solution. ubTrace provides:

   * Historical data tracking across documentation builds
   * Trend visualization over time
   * Easy configuration for project management workflows
   * Integration with CI/CD pipelines for automatic tracking

   Learn more at: `useblocks ubTrace <https://useblocks.com>`_

Next Steps
----------

Now that you can create dashboards, explore these related topics:

* :ref:`how-to-write-requirements` - Define effective requirements
* :ref:`external-needs` - Import needs from external systems
* :ref:`gh-actions-build` - Automate dashboard builds in CI/CD

.. seealso::

   **sphinx-needs Documentation:**

   * `Directives Reference <https://sphinx-needs.readthedocs.io/en/latest/directives/index.html>`_ - Complete API for all directives
   * `Filter Expressions <https://sphinx-needs.readthedocs.io/en/latest/filter.html>`_ - Advanced filtering syntax
   * `Configuration Options <https://sphinx-needs.readthedocs.io/en/latest/configuration.html>`_ - All conf.py settings
   * `Layouts & Styles <https://sphinx-needs.readthedocs.io/en/latest/layout_styles.html>`_ - Customize need appearance

   **External Resources:**

   * `Matplotlib Styles <https://matplotlib.org/stable/gallery/style_sheets/style_sheets_reference.html>`_
   * `Graphviz Documentation <https://graphviz.org/documentation/>`_
