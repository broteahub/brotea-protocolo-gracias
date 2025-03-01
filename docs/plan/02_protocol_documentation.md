# Brotea Gracias Protocol Documentation

## Project Summary
The Brotea Gracias Protocol is a web3/web2 hybrid system designed to manage and incentivize appreciations between various entities (individuals, projects, communities) within the Brotea ecosystem. The protocol leverages blockchain technology to record appreciations, distribute rewards, and create a transparent, verifiable system of recognition that builds community and reinforces positive interactions.

## Key Objectives
- Create a decentralized appreciation system that works across web2 and web3 platforms
- Integrate with Warpcast for user authentication and social interaction
- Implement a token-based reward system for appreciations
- Enable users to create and manage public appreciation panels
- Provide SDK components for displaying appreciations on external sites
- Establish a sustainable economic model through transaction fees
- Distribute rewards to the most meaningful appreciations using AI sentiment analysis

## System Context

### Key Stakeholders
1. **End Users** - People who want to acknowledge others or receive appreciations
2. **Panel Creators** - Users who create and manage appreciation panels
3. **Web2 Visitors** - Non-wallet users who can validate appreciations via likes
4. **Protocol Administrators** - Brotea team managing the protocol infrastructure
5. **AI Agent (ElizaOS)** - Automated system for detecting and processing appreciations

### Technical Stack
- **Frontend**: Next.js
- **AI Agent**: ElizaOS
- **Blockchain**: Flow
- **Social Integration**: Warpcast

### Integration Points
- Warpcast API for authentication and social posts
- Flow blockchain for recording appreciations and managing tokens
- ElizaOS for AI-powered appreciation detection and sentiment analysis
- Brotea's existing open-source components

## Use Case Diagrams

### User Registration and Setup

```mermaid
flowchart TD
    User([User])
    
    subgraph "Brotea Gracias Protocol"
        Register[Register with Protocol]
        ConfigWarpcast[Configure Warpcast Account]
        CreatePanel[Create Appreciation Panel]
        ConfigPanel[Configure Panel Settings]
        ConfigHashtag[Set Panel Hashtag]
    end
    
    User -->|Signs up| Register
    Register -->|Requires| ConfigWarpcast
    User -->|Creates| CreatePanel
    CreatePanel -->|Includes| ConfigPanel
    ConfigPanel -->|Defines| ConfigHashtag
```

### Sending Appreciations

```mermaid
flowchart TD
    User([User])
    
    subgraph "Warpcast"
        Post[Create Post]
        Mention[Mention User]
        UseHashtag[Include Panel Hashtag]
    end
    
    subgraph "ElizaOS Agent"
        Detect[Detect Appreciation]
        Process[Process Transaction]
        Record[Record on Blockchain]
        Distribute[Distribute Rewards]
    end
    
    User -->|Posts on| Post
    Post -->|Contains| Mention
    Post -->|Contains| UseHashtag
    Mention & UseHashtag -->|Triggers| Detect
    Detect -->|Initiates| Process
    Process -->|Creates| Record
    Process -->|Handles| Distribute
```

### Appreciation Panel Interaction

```mermaid
flowchart TD
    User([User])
    Visitor([Web2 Visitor])
    
    subgraph "Appreciation Panel"
        ViewSent[View Sent Appreciations]
        ViewReceived[View Received Appreciations]
        LikeAck[Like Appreciation]
        PrepareTemplate[Prepare Appreciation Template]
    end
    
    subgraph "SDK Components"
        DisplayList[Display Appreciation List]
        RenderButton[Render Thank Button]
    end
    
    User -->|Accesses| ViewSent
    User -->|Accesses| ViewReceived
    User -->|Uses| PrepareTemplate
    PrepareTemplate -->|Posts to| Warpcast
    
    Visitor -->|Can| LikeAck
    LikeAck -->|May trigger| Onboarding[Web3 Onboarding]
    
    ViewSent & ViewReceived -->|Rendered by| DisplayList
    PrepareTemplate -->|Uses| RenderButton
```

### Weekly Reward Distribution

```mermaid
flowchart TD
    System([System])
    
    subgraph "Weekly Process"
        Collect[Collect Protocol Fees]
        Analyze[AI Sentiment Analysis]
        Identify[Identify Top Appreciations]
        Distribute[Distribute USDC Rewards]
    end
    
    System -->|Initiates weekly| Collect
    Collect -->|Provides data for| Analyze
    Analyze -->|Determines| Identify
    Identify -->|Triggers| Distribute
    Distribute -->|Rewards to| TopUsers[Top 3 Appreciations]
```

## Component Diagrams

### System Architecture

```mermaid
flowchart TD
    subgraph "Frontend Layer"
        NextJS[Next.js Application]
        SDK[Brotea SDK Components]
        Panels[Appreciation Panels]
    end
    
    subgraph "Integration Layer"
        WarpcastAPI[Warpcast API Client]
        FlowSDK[Flow Blockchain SDK]
        BroteaComponents[Brotea Open Source Components]
    end
    
    subgraph "Backend Layer"
        ElizaOS[ElizaOS AI Agent]
        ProtocolCore[Protocol Core Logic]
        RewardSystem[Reward Distribution System]
    end
    
    subgraph "Blockchain Layer"
        FlowContracts[Flow Smart Contracts]
        TokenManagement[Token Management]
        TransactionHistory[Transaction History]
    end
    
    NextJS <-->|Renders| SDK
    NextJS <-->|Displays| Panels
    SDK <-->|Uses| BroteaComponents
    SDK <-->|Communicates with| WarpcastAPI
    SDK <-->|Interacts with| FlowSDK
    
    WarpcastAPI <-->|Monitors posts| ElizaOS
    ElizaOS <-->|Processes appreciations| ProtocolCore
    ProtocolCore <-->|Manages rewards| RewardSystem
    ProtocolCore <-->|Executes transactions| FlowSDK
    
    FlowSDK <-->|Interacts with| FlowContracts
    FlowContracts <-->|Manages| TokenManagement
    FlowContracts <-->|Records| TransactionHistory
```

### User Flow Components

```mermaid
flowchart TD
    subgraph "User Interface Components"
        Registration[Registration Module]
        PanelCreation[Panel Creation Interface]
        AckViewer[Appreciation Viewer]
        ThankButton[Thank Button Component]
        LikeButton[Like Button Component]
    end
    
    subgraph "Backend Services"
        UserAuth[User Authentication]
        WarpcastIntegration[Warpcast Integration]
        BlockchainService[Blockchain Service]
        AIProcessor[AI Processing Service]
        RewardDistributor[Reward Distribution Service]
    end
    
    Registration -->|Uses| UserAuth
    Registration -->|Connects to| WarpcastIntegration
    
    PanelCreation -->|Configures| AckViewer
    PanelCreation -->|Sets up| ThankButton
    
    AckViewer -->|Displays data from| BlockchainService
    ThankButton -->|Posts via| WarpcastIntegration
    LikeButton -->|Records to| BlockchainService
    
    WarpcastIntegration -->|Monitored by| AIProcessor
    AIProcessor -->|Triggers| BlockchainService
    BlockchainService -->|Provides data to| RewardDistributor
```

### Data Flow Components

```mermaid
flowchart TD
    subgraph "Data Sources"
        WarpcastPosts[Warpcast Posts]
        UserProfiles[User Profiles]
        PanelConfigs[Panel Configurations]
        BlockchainRecords[Blockchain Records]
    end
    
    subgraph "Processing Components"
        PostMonitor[Post Monitoring Service]
        AckDetector[Appreciation Detector]
        SentimentAnalyzer[Sentiment Analyzer]
        TransactionProcessor[Transaction Processor]
    end
    
    subgraph "Storage Components"
        UserDB[User Database]
        PanelDB[Panel Database]
        AckDB[Appreciation Database]
        RewardDB[Reward Distribution Database]
    end
    
    WarpcastPosts -->|Monitored by| PostMonitor
    PostMonitor -->|Feeds into| AckDetector
    AckDetector -->|Analyzes with| SentimentAnalyzer
    SentimentAnalyzer -->|Triggers| TransactionProcessor
    
    UserProfiles -->|Stored in| UserDB
    PanelConfigs -->|Stored in| PanelDB
    
    TransactionProcessor -->|Records to| BlockchainRecords
    BlockchainRecords -->|Indexed in| AckDB
    
    AckDB -->|Used for| RewardDB
```

## Risk/Constraints Matrix

| Risk/Constraint | Impact | Mitigation Strategy |
|-----------------|--------|---------------------|
| Warpcast API limitations | High | Implement robust error handling and rate limiting compliance |
| Flow blockchain transaction costs | Medium | Optimize batch processing and fee structure |
| AI accuracy in detecting appreciations | High | Continuous training and human review of edge cases |
| User adoption of web3 features | Medium | Provide seamless web2 experience with optional web3 onboarding |
| Security of user wallets | Critical | Leverage Warpcast's security model and add additional safeguards |
| Scalability of reward distribution | Medium | Implement efficient smart contracts and optimize gas usage |
| Regulatory compliance for token distribution | High | Consult legal experts and implement necessary compliance measures |
| Integration complexity with existing systems | Medium | Develop clear APIs and comprehensive documentation |

## Success Metrics

| Metric | Target | Measurement Method |
|--------|--------|-------------------|
| User Registration | 10,000 users in first 6 months | User database count |
| Appreciation Panels Created | 1,000 panels in first 3 months | Panel database count |
| Weekly Appreciations Processed | 5,000 per week by month 6 | Transaction logs |
| Web2 to Web3 Conversion Rate | 15% of web2 users onboard to web3 | Onboarding funnel analytics |
| Protocol Fee Revenue | Cover operational costs by month 9 | Financial reporting |
| User Retention | 70% monthly active user retention | Usage analytics |
| Sentiment Score Improvement | 25% increase in positive sentiment | AI sentiment analysis reports |
| SDK Integration | 100 external sites using SDK by year 1 | Integration tracking |

## Implementation Roadmap

1. **Phase 1: Core Infrastructure**
   - User registration and Warpcast integration
   - Basic appreciation detection
   - Flow contract development

2. **Phase 2: Panel System**
   - Panel creation and management
   - SDK development for external sites
   - Appreciation viewing components

3. **Phase 3: Reward Mechanism**
   - Transaction fee collection
   - AI sentiment analysis integration
   - Weekly reward distribution system

4. **Phase 4: Web2/Web3 Bridge**
   - Like button functionality
   - Web3 onboarding flow
   - Enhanced social features
