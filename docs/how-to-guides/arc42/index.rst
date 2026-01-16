.. _arc42-architecture:

:octicon:`package` Architecture Documentation with arc42
========================================================

This guide demonstrates how to document software architecture using the arc42 template combined with Sphinx-Needs directives. This approach enables systematic architecture documentation with full traceability between architecture decisions, components, and requirements.

What is arc42?
--------------

`arc42 <https://arc42.org/>`_ is a proven, practical, and pragmatic template for software architecture documentation and communication. It provides a standardized structure with 12 sections covering all aspects of software architecture.

Why Combine arc42 with Sphinx-Needs?
-------------------------------------

By integrating arc42 with Sphinx-Needs, you gain:

* **Traceability**: Link architecture elements to requirements, design decisions, and test cases
* **Filtering**: Query and display specific architecture elements based on criteria
* **Consistency**: Ensure all architecture components are properly documented
* **Navigation**: Automatic cross-references between related architecture elements
* **Reporting**: Generate architecture overviews, dependency matrices, and more

arc42 Structure Overview
-------------------------

The arc42 template consists of 12 sections:

1. Introduction and Goals
2. Constraints
3. Context and Scope
4. Solution Strategy
5. Building Block View
6. Runtime View
7. Deployment View
8. Crosscutting Concepts
9. Architecture Decisions
10. Quality Requirements
11. Risks and Technical Debt
12. Glossary

Custom Sphinx-Needs Types for arc42
------------------------------------

Define custom need types in your ``conf.py`` to represent arc42 elements:

.. code-block:: python

   needs_types = [
       # ... existing types
       {
           "directive": "arch-goal",
           "title": "Architecture Goal",
           "prefix": "AG_",
           "color": "#BFD8D2",
           "style": "node"
       },
       {
           "directive": "constraint",
           "title": "Constraint",
           "prefix": "CON_",
           "color": "#FEDCD2",
           "style": "node"
       },
       {
           "directive": "building-block",
           "title": "Building Block",
           "prefix": "BB_",
           "color": "#DF744A",
           "style": "node"
       },
       {
           "directive": "arch-decision",
           "title": "Architecture Decision",
           "prefix": "ADR_",
           "color": "#DCB239",
           "style": "node"
       },
       {
           "directive": "quality-goal",
           "title": "Quality Goal",
           "prefix": "QG_",
           "color": "#BFD8D2",
           "style": "node"
       },
   ]

Section 1: Introduction and Goals
----------------------------------

Quality Goals
~~~~~~~~~~~~~

.. quality-goal:: High Performance
   :id: QG_001
   :status: open
   :tags: performance, quality

   The system must handle 10,000 concurrent users with response times under 200ms for 95% of requests.

.. quality-goal:: Maintainability
   :id: QG_002
   :status: open
   :tags: maintainability, quality

   Code must follow clean architecture principles to ensure long-term maintainability and testability.

.. quality-goal:: Security
   :id: QG_003
   :status: open
   :tags: security, quality

   All data transmission must be encrypted, and authentication must use industry-standard protocols (OAuth 2.0, JWT).

Stakeholders
~~~~~~~~~~~~

.. spec:: Product Owner
   :id: STAKE_001
   :tags: stakeholder

   **Expectations**: Feature completeness, time-to-market, ROI
   
   **Influence**: High - Sets priorities and acceptance criteria

.. spec:: Development Team
   :id: STAKE_002
   :tags: stakeholder

   **Expectations**: Clear requirements, technical feasibility, maintainable codebase
   
   **Influence**: High - Implements and maintains the system

Section 2: Constraints
----------------------

Technical Constraints
~~~~~~~~~~~~~~~~~~~~~

.. constraint:: Programming Language: Python
   :id: CON_001
   :status: accepted
   :tags: technical, language

   The system must be implemented in Python 3.12+ to leverage existing team expertise and tooling.

.. constraint:: Cloud Platform: AWS
   :id: CON_002
   :status: accepted
   :tags: technical, infrastructure

   Deployment must use AWS services due to existing enterprise agreement and compliance requirements.

Organizational Constraints
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. constraint:: Team Size
   :id: CON_003
   :status: accepted
   :tags: organizational

   Development team is limited to 5 developers, requiring architecture that minimizes coordination overhead.

.. constraint:: Budget Limitation
   :id: CON_004
   :status: accepted
   :tags: organizational, budget

   Infrastructure costs must not exceed $5,000/month in production.

Section 3: Context and Scope
-----------------------------

Business Context
~~~~~~~~~~~~~~~~

.. arch:: System Context
   :id: ARCH_CTX_001
   :links: QG_001, QG_002, QG_003

   External interfaces and system boundaries:

   .. uml::

      @startuml
      !define RECTANGLE class
      
      actor User
      actor Admin
      
      rectangle "EAC System" {
          component [API Gateway] as API
          component [Documentation Engine] as DocEngine
          component [Build System] as Build
      }
      
      database "Document Store" as DB
      cloud "External Systems" {
          component [Version Control] as VCS
          component [CI/CD] as CICD
      }
      
      User --> API : Browse/Search Docs
      Admin --> API : Manage Content
      API --> DocEngine : Process Requests
      DocEngine --> Build : Generate Docs
      Build --> DB : Store Artifacts
      DocEngine <--> VCS : Fetch Sources
      Build <--> CICD : Trigger Builds
      @enduml

Technical Context
~~~~~~~~~~~~~~~~~

.. arch:: Technical Interfaces
   :id: ARCH_CTX_002

   Integration points with external systems:

   * **REST API**: JSON over HTTPS, OAuth 2.0 authentication
   * **Git Integration**: SSH/HTTPS for repository access
   * **Database**: PostgreSQL 14+ with connection pooling
   * **Message Queue**: Redis for background job processing

Section 4: Solution Strategy
-----------------------------

.. arch-decision:: Use Microservices Architecture
   :id: ADR_001
   :status: accepted
   :links: QG_001, QG_002, CON_003

   **Context**: Need to scale different components independently while maintaining team autonomy.

   **Decision**: Adopt microservices architecture with domain-driven design.

   **Consequences**: 
   
   * ✅ Independent scaling and deployment
   * ✅ Technology diversity where appropriate
   * ❌ Increased operational complexity
   * ❌ Need for service mesh and API gateway

.. arch-decision:: Event-Driven Communication
   :id: ADR_002
   :status: accepted
   :links: ADR_001, QG_001

   **Context**: Microservices need to communicate without tight coupling.

   **Decision**: Use event-driven architecture with Redis Streams for inter-service communication.

   **Consequences**:
   
   * ✅ Loose coupling between services
   * ✅ Better fault tolerance
   * ❌ Eventual consistency challenges
   * ❌ More complex debugging

Section 5: Building Block View
-------------------------------

Level 1: System Overview
~~~~~~~~~~~~~~~~~~~~~~~~~

.. building-block:: EAC Documentation System
   :id: BB_001
   :links: ARCH_CTX_001

   Top-level system components:

   * **API Gateway**: Entry point for all external requests
   * **Documentation Service**: Core documentation processing
   * **Build Service**: Sphinx documentation builds
   * **Storage Service**: Document artifact management
   * **Search Service**: Full-text search capabilities

Level 2: Component Details
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. building-block:: API Gateway
   :id: BB_002
   :links: BB_001, ADR_001

   Responsibilities:
   
   * Request routing and load balancing
   * Authentication and authorization
   * Rate limiting and throttling
   * Request/response transformation

   Technologies:
   
   * Kong API Gateway
   * OAuth 2.0 / JWT
   * Redis for rate limiting

.. building-block:: Documentation Service
   :id: BB_003
   :links: BB_001, ADR_001

   Responsibilities:
   
   * Parse and validate documentation sources
   * Manage documentation projects
   * Coordinate build triggers
   * Handle version management

   Technologies:
   
   * Python/FastAPI
   * PostgreSQL for metadata
   * GitPython for repository access

.. building-block:: Build Service
   :id: BB_004
   :links: BB_001, BB_003, CON_001

   Responsibilities:
   
   * Execute Sphinx builds in isolated environments
   * Generate multiple output formats (HTML, PDF)
   * Handle build artifacts
   * Report build status

   Technologies:
   
   * Python/Celery for task queue
   * Docker for build isolation
   * Sphinx + sphinx-needs

Component Relationships
~~~~~~~~~~~~~~~~~~~~~~~

.. arch:: Component Interaction
   :id: ARCH_BB_001
   :links: BB_002, BB_003, BB_004

   .. mermaid::

      graph TD
         User[User/Client] -->|HTTPS| AG[API Gateway]
         AG -->|REST| DS[Documentation Service]
         AG -->|REST| SS[Search Service]
         DS -->|Events| BS[Build Service]
         DS -->|Read/Write| DB[(PostgreSQL)]
         BS -->|Store| S3[S3 Storage]
         BS -->|Index| SS
         BS -->|Clone| Git[Git Repository]
         
         style AG fill:#BFD8D2
         style DS fill:#DF744A
         style BS fill:#DF744A
         style SS fill:#DF744A

Section 6: Runtime View
------------------------

.. arch:: Documentation Build Flow
   :id: ARCH_RV_001
   :links: BB_003, BB_004

   Sequence of events when a documentation build is triggered:

   .. uml::

      @startuml
      actor User
      participant "API Gateway" as AG
      participant "Doc Service" as DS
      participant "Build Service" as BS
      participant "Git Repo" as Git
      participant "Storage" as S3

      User -> AG: POST /projects/{id}/build
      AG -> DS: Trigger Build
      DS -> DS: Validate Request
      DS -> BS: Queue Build Job
      DS --> User: 202 Accepted (Job ID)
      
      BS -> Git: Clone Repository
      Git --> BS: Source Files
      BS -> BS: Run Sphinx Build
      BS -> S3: Upload Artifacts
      BS -> DS: Update Build Status
      DS --> User: Notification (Success)
      @enduml

.. arch:: Search Query Flow
   :id: ARCH_RV_002

   How search requests are processed:

   .. mermaid::

      sequenceDiagram
         participant U as User
         participant AG as API Gateway
         participant SS as Search Service
         participant ES as Elasticsearch
         participant Cache as Redis Cache

         U->>AG: GET /search?q=architecture
         AG->>Cache: Check Cache
         alt Cache Hit
            Cache-->>AG: Cached Results
            AG-->>U: Return Results (Fast)
         else Cache Miss
            AG->>SS: Forward Query
            SS->>ES: Execute Search
            ES-->>SS: Results
            SS->>Cache: Store in Cache
            SS-->>AG: Results
            AG-->>U: Return Results
         end

Section 7: Deployment View
---------------------------

.. arch:: Production Deployment
   :id: ARCH_DV_001
   :links: CON_002, BB_002, BB_003, BB_004

   AWS infrastructure layout:

   .. uml::

      @startuml
      !include <C4/C4_Context>
      
      skinparam rectangle {
         BackgroundColor<<cdn>> LightBlue
         BackgroundColor<<lb>> LightGreen
         BackgroundColor<<app>> LightYellow
         BackgroundColor<<db>> Pink
         BackgroundColor<<storage>> Orange
      }
      
      package "AWS Cloud" {
         rectangle "CloudFront\nCDN" as cdn <<cdn>>
         
         package "VPC" {
            package "Public Subnet" {
               rectangle "Application LB\nLoad Balancer" as alb <<lb>>
            }
            
            package "Private Subnet" {
               rectangle "API Gateway\nt3.medium" as app1 <<app>>
               rectangle "Doc Service\nt3.medium" as app2 <<app>>
               rectangle "Build Workers\nt3.large" as worker <<app>>
               database "PostgreSQL\ndb.t3.medium" as db <<db>>
            }
         }
         
         storage "S3 Bucket\nArtifacts" as s3 <<storage>>
      }

      cdn --> alb
      alb --> app1
      alb --> app2
      app2 --> db
      app2 --> worker
      worker --> s3
      @enduml

Section 8: Crosscutting Concepts
---------------------------------

Logging and Monitoring
~~~~~~~~~~~~~~~~~~~~~~

.. spec:: Structured Logging
   :id: CROSS_001
   :tags: logging, monitoring

   All services use structured JSON logging with:
   
   * Correlation IDs for request tracing
   * Log levels: DEBUG, INFO, WARNING, ERROR, CRITICAL
   * Centralized logging via AWS CloudWatch

Security Concepts
~~~~~~~~~~~~~~~~~

.. spec:: Authentication and Authorization
   :id: CROSS_002
   :tags: security
   :links: QG_003

   * OAuth 2.0 for user authentication
   * JWT tokens for session management
   * Role-based access control (RBAC)
   * API key authentication for service-to-service

Error Handling
~~~~~~~~~~~~~~

.. spec:: Error Handling Strategy
   :id: CROSS_003
   :tags: error-handling

   Consistent error responses across all services:
   
   .. code-block:: json

      {
         "error": {
            "code": "BUILD_FAILED",
            "message": "Documentation build failed",
            "details": "Sphinx error: ...",
            "timestamp": "2025-11-12T10:30:00Z",
            "trace_id": "abc123"
         }
      }

Section 9: Architecture Decisions
----------------------------------

Decision Records
~~~~~~~~~~~~~~~~

All major architecture decisions are documented using the ADR format shown above. Key decisions include:

.. needtable::
   :filter: "ADR_" in id
   :columns: id, title, status, links
   :style: table

Section 10: Quality Requirements
---------------------------------

Quality Scenarios
~~~~~~~~~~~~~~~~~

.. spec:: Performance Scenario
   :id: QS_001
   :links: QG_001

   **Scenario**: 1000 users simultaneously request documentation pages
   
   **Expected Response**: 
   
   * 95% of requests complete within 200ms
   * No failed requests
   * CPU utilization stays below 70%

.. spec:: Availability Scenario
   :id: QS_002

   **Scenario**: Single service instance fails
   
   **Expected Response**:
   
   * Automatic failover within 30 seconds
   * No data loss
   * Service degradation < 5%

Quality Tree
~~~~~~~~~~~~

.. arch:: Quality Attribute Tree
   :id: ARCH_QA_001
   :links: QG_001, QG_002, QG_003

   .. mermaid::

      graph TD
         Q[Quality Goals] --> P[Performance]
         Q --> M[Maintainability]
         Q --> S[Security]
         
         P --> P1[Response Time < 200ms]
         P --> P2[Throughput > 10k req/s]
         
         M --> M1[Test Coverage > 80%]
         M --> M2[Clear Architecture]
         
         S --> S1[Encryption at Rest]
         S --> S2[Secure Authentication]

Section 11: Risks and Technical Debt
-------------------------------------

.. spec:: Risk: Scaling Challenges
   :id: RISK_001
   :status: open
   :tags: risk, scaling

   **Risk**: Build service may not scale to handle peak loads
   
   **Probability**: Medium
   
   **Impact**: High - Could cause build delays
   
   **Mitigation**: 
   
   * Implement auto-scaling for build workers
   * Add build queue prioritization
   * Monitor build times and queue lengths

.. spec:: Technical Debt: Legacy API Endpoints
   :id: DEBT_001
   :status: open
   :tags: technical-debt

   **Description**: Some API endpoints use deprecated patterns
   
   **Impact**: Inconsistent API design, harder to maintain
   
   **Planned Resolution**: Q2 2026 - API v2 migration

Section 12: Glossary
--------------------

.. spec:: Documentation Artifact
   :id: GLOSS_001
   :tags: glossary

   A compiled output from the documentation build process, typically HTML, PDF, or other formats.

.. spec:: Build Job
   :id: GLOSS_002
   :tags: glossary

   An asynchronous task that processes documentation sources and generates artifacts.

.. spec:: Sphinx-Needs Directive
   :id: GLOSS_003
   :tags: glossary

   A reStructuredText directive that creates traceable documentation elements (requirements, specs, etc.).

Traceability Views
------------------

Architecture to Requirements
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Show which architecture components fulfill which quality goals:

.. needtable::
   :filter: "BB_" in id or "ADR_" in id
   :columns: id, title, links
   :style: table

Complete Architecture Overview
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Visualize all architecture elements and their relationships:

.. needflow::
   :filter: "ARCH_" in id or "BB_" in id or "ADR_" in id
   :tags: architecture
   :show_link_names:

Summary
-------

This approach combines the proven arc42 template with Sphinx-Needs' traceability features to create:

✅ **Structured Documentation**: Follow industry-standard architecture documentation template

✅ **Full Traceability**: Link architecture decisions to requirements, components, and quality goals

✅ **Living Documentation**: Keep architecture docs synchronized with implementation

✅ **Automated Reporting**: Generate views, matrices, and reports from architecture data

✅ **Version Controlled**: All architecture documentation in Git alongside code

Best Practices
--------------

1. **Start Simple**: Don't fill all 12 sections at once. Focus on what's important for your project.
2. **Keep It Updated**: Review and update architecture docs with each sprint/iteration.
3. **Use IDs Consistently**: Follow ID prefix conventions
4. **Link Liberally**: Connect related architecture elements using the ``:links:`` option.
5. **Visualize**: Use diagrams (PlantUML, Mermaid, Draw.io) to illustrate concepts.
6. **Review Together**: Make architecture reviews part of your regular process.

Additional Resources
--------------------

* `arc42 Documentation <https://docs.arc42.org/>`_
* `arc42 Examples <https://arc42.org/examples>`_
* `Sphinx-Needs Documentation <https://sphinx-needs.readthedocs.io/>`_
* `C4 Model <https://c4model.com/>`_ - Complementary architecture visualization approach
