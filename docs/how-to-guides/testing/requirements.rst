.. _test-requirements:

Test Requirements
=================

This section defines the requirements that the test cases verify.

Mathematical Functions
----------------------

.. req:: Factorial Function
   :id: REQ_MATH_001
   :status: open
   :tags: math, factorial

   The system shall provide a factorial function that:
   
   * Returns the factorial n! for positive integers
   * Returns 1 for zero (0! = 1)
   * Returns 1 for negative numbers (edge case handling)
   
   **Rationale**: Factorial calculation is needed for mathematical operations and combinatorics.

.. req:: Prime Number Detection
   :id: REQ_MATH_002
   :status: open
   :tags: math, prime

   The system shall provide a function to determine if a number is prime that:
   
   * Returns false for negative numbers
   * Returns false for 0 and 1
   * Returns true for 2 and 3
   * Correctly identifies prime and composite positive integers
   
   **Rationale**: Prime number detection is used in cryptographic operations and number theory calculations.

Implementation
--------------

These implementations are automatically discovered from source code comments using sphinx-codelinks:

* ``IMPL_2`` - Factorial Function Implementation in ``src/sample1.cpp``
* ``IMPL_3`` - Prime Number Detection Implementation in ``src/sample1.cpp``

See the :ref:`src-tracing` guide for details on how source code tracing works.

Traceability Overview
---------------------

The traceability chain:

.. mermaid::

   graph TD
      REQ_MATH_001 --> TS_FACTORIAL
      REQ_MATH_002 --> TS_PRIME
      TS_FACTORIAL --> T_FACT_001
      TS_FACTORIAL --> T_FACT_002
      TS_FACTORIAL --> T_FACT_003
      TS_PRIME --> T_PRIME_001
      TS_PRIME --> T_PRIME_002
      TS_PRIME --> T_PRIME_003
      T_FACT_001 --> IMPL_2
      T_FACT_002 --> IMPL_2
      T_FACT_003 --> IMPL_2
      T_PRIME_001 --> IMPL_3
      T_PRIME_002 --> IMPL_3
      T_PRIME_003 --> IMPL_3
      
      style REQ_MATH_001 fill:#FFB300
      style REQ_MATH_002 fill:#FFB300
      style TS_FACTORIAL fill:#A6BDD7
      style TS_PRIME fill:#A6BDD7
      style IMPL_2 fill:#fa8638
      style IMPL_3 fill:#fa8638

Requirements Coverage Matrix
-----------------------------

.. needtable::
   :filter: "REQ_MATH_" in id
   :columns: id, title, status, tags
   :style: table
