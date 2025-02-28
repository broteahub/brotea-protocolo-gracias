# Brotea Gracias Protocol - Use Case Diagrams

This document provides formal UML use case diagrams for the Brotea Gracias Protocol, detailing the interactions between actors and the system.

## Primary Actors

- **End User**: Person who wants to acknowledge others or receive appreciations
- **Panel Creator**: User who creates and manages appreciation panels
- **Web2 Visitor**: Non-wallet user who can validate appreciations via likes
- **Protocol Administrator**: Brotea team member managing the protocol infrastructure
- **ElizaOS Agent**: AI system for detecting and processing appreciations
- **Warpcast Platform**: External social platform integrated with the protocol
- **Flow Blockchain**: External blockchain system for recording transactions

## Use Case Diagram: User Management

```mermaid
flowchart TD
    User([End User])
    PanelCreator([Panel Creator])
    Admin([Protocol Administrator])
    
    subgraph "Brotea Gracias Protocol"
        Register[Register with Protocol]
        LinkWarpcast[Link Warpcast Account]
        ManageProfile[Manage User Profile]
        CreatePanel[Create Appreciation Panel]
        ConfigurePanel[Configure Panel Settings]
        ManageUsers[Manage User Accounts]
        ViewAnalytics[View System Analytics]
    end
    
    User -->|Performs| Register
    User -->|Performs| LinkWarpcast
    User -->|Performs| ManageProfile
    
    PanelCreator -->|Performs| Register
    PanelCreator -->|Performs| LinkWarpcast
    PanelCreator -->|Performs| ManageProfile
    PanelCreator -->|Performs| CreatePanel
    PanelCreator -->|Performs| ConfigurePanel
    
    Admin -->|Performs| ManageUsers
    Admin -->|Performs| ViewAnalytics
```

## Use Case Diagram: Appreciation Operations

```mermaid
flowchart TD
    User([End User])
    PanelCreator([Panel Creator])
    Web2Visitor([Web2 Visitor])
    ElizaOS([ElizaOS Agent])
    Warpcast([Warpcast Platform])
    Flow([Flow Blockchain])
    
    subgraph "Brotea Gracias Protocol"
        PostAck[Post Appreciation]
        ViewSentAcks[View Sent Appreciations]
        ViewReceivedAcks[View Received Appreciations]
        LikeAck[Like Appreciation]
        DetectAck[Detect Appreciation in Post]
        ProcessTransaction[Process Blockchain Transaction]
        RecordAck[Record Appreciation]
        OnboardToWeb3[Onboard to Web3]
    end
    
    User -->|Performs| PostAck
    User -->|Performs| ViewSentAcks
    User -->|Performs| ViewReceivedAcks
    User -->|Performs| LikeAck
    
    PanelCreator -->|Performs| ViewSentAcks
    PanelCreator -->|Performs| ViewReceivedAcks
    
    Web2Visitor -->|Performs| LikeAck
    Web2Visitor -->|May perform| OnboardToWeb3
    
    PostAck -->|Uses| Warpcast
    Warpcast -->|Triggers| ElizaOS
    
    ElizaOS -->|Performs| DetectAck
    ElizaOS -->|Initiates| ProcessTransaction
    
    ProcessTransaction -->|Uses| Flow
    Flow -->|Enables| RecordAck
```

## Use Case Diagram: Panel Management

```mermaid
flowchart TD
    PanelCreator([Panel Creator])
    User([End User])
    
    subgraph "Brotea Gracias Protocol"
        CreatePanel[Create Appreciation Panel]
        ConfigureHashtag[Configure Panel Hashtag]
        CustomizeTemplate[Customize Appreciation Template]
        EmbedPanel[Embed Panel on External Site]
        ViewPanelAnalytics[View Panel Analytics]
        BrowsePanels[Browse Public Panels]
    end
    
    PanelCreator -->|Performs| CreatePanel
    PanelCreator -->|Performs| ConfigureHashtag
    PanelCreator -->|Performs| CustomizeTemplate
    PanelCreator -->|Performs| EmbedPanel
    PanelCreator -->|Performs| ViewPanelAnalytics
    
    User -->|Performs| BrowsePanels
```

## Use Case Diagram: Reward System

```mermaid
flowchart TD
    System([System])
    ElizaOS([ElizaOS Agent])
    Admin([Protocol Administrator])
    User([End User])
    
    subgraph "Brotea Gracias Protocol"
        CollectFees[Collect Transaction Fees]
        AnalyzeSentiment[Analyze Appreciation Sentiment]
        RankAppreciations[Rank Appreciations by Impact]
        DistributeRewards[Distribute Weekly Rewards]
        ConfigureRewards[Configure Reward Parameters]
        ViewRewardHistory[View Reward History]
    end
    
    System -->|Performs| CollectFees
    System -->|Initiates| DistributeRewards
    
    ElizaOS -->|Performs| AnalyzeSentiment
    AnalyzeSentiment -->|Enables| RankAppreciations
    RankAppreciations -->|Informs| DistributeRewards
    
    Admin -->|Performs| ConfigureRewards
    
    User -->|Performs| ViewRewardHistory
```

## Use Case Diagram: SDK Integration

```mermaid
flowchart TD
    Developer([External Developer])
    PanelCreator([Panel Creator])
    
    subgraph "Brotea Gracias Protocol SDK"
        IntegrateSDK[Integrate SDK]
        DisplayAppreciations[Display Appreciations]
        RenderThankButton[Render Thank Button]
        RenderLikeButton[Render Like Button]
        CustomizeDisplay[Customize Display]
        FetchAppreciations[Fetch Appreciation Data]
    end
    
    Developer -->|Performs| IntegrateSDK
    Developer -->|Configures| DisplayAppreciations
    Developer -->|Configures| RenderThankButton
    Developer -->|Configures| RenderLikeButton
    Developer -->|Performs| CustomizeDisplay
    
    PanelCreator -->|Configures| DisplayAppreciations
    
    DisplayAppreciations -->|Uses| FetchAppreciations
    RenderThankButton -->|Uses| FetchAppreciations
    RenderLikeButton -->|Uses| FetchAppreciations
