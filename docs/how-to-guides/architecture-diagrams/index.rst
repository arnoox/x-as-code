.. _architecture-diagrams:

:octicon:`organization` Architecture Diagrams
=============================================

This guide demonstrates how architecture diagrams — whether for systems, 
components, or software — can be generated and traced directly within documentation. 

By integrating visualization tools such as PlantUML and Mermaid, 
you can easily create clear, interactive diagrams that enhance 
understanding and communication of architectural concepts.


.. arch:: Lane Detection Module
   :id: ARCH_001
   :status: open

   Design the architecture for the Lane Detection Module, including components for camera input processing, lane identification, and integration with steering control.

   .. uml::

      @startuml
      node "Vehicle" {
          component LaneDetection  {
              agent detectLaneMarkings
              agent applySteeringCorrection
          }
          component CameraInput {
              agent captureData
          }
          component SteeringControl {
              agent correctSteering
          }
      }
      CameraInput --> LaneDetection
      LaneDetection --> SteeringControl
      @enduml

.. arch:: Alice and Bob Authentication Request
    :id: ARCH_002

    Architecture diagram using PlantUML.

    .. uml::

      @startuml
      Alice -> Bob: Authentication Request

      alt successful case

          Bob -> Alice: Authentication Accepted

      else some kind of failure

          Bob -> Alice: Authentication Failure
          group My own label
          Alice -> Log : Log attack start
              loop 1000 times
                  Alice -> Bob: DNS Attack
              end
          Alice -> Log : Log attack end
          end

      else Another type of failure

      Bob -> Alice: Please repeat

      end
      @enduml

.. arch:: Arch Diagram using Mermaid
    :id: ARCH_003
    
    .. mermaid::

        ---
        config:
          theme: 'forest'
        ---
        sequenceDiagram
          participant Alice
          participant Bob
          Alice->John: Hello John, how are you?
          loop Healthcheck
              John->John: Fight against hypochondria
          end
          Note right of John: Rational thoughts <br/>prevail...
          John-->Alice: Great!
          John->Bob: How about you?
          Bob-->John: Jolly good!

