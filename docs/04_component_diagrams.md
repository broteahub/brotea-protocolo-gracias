# Brotea Gracias Protocol - Component Diagrams

This document provides detailed component diagrams for the Brotea Gracias Protocol, illustrating the technical architecture and interactions between system components.

## Technology Stack Overview

- **Frontend**: Next.js
- **AI Agent**: ElizaOS
- **Blockchain**: Flow
- **Social Integration**: Warpcast
- **Open Source Components**: Brotea ecosystem components

## System Architecture Components

```mermaid
flowchart TD
    subgraph "Client Layer"
        WebApp[Web Application]
        MobileApp[Mobile View]
        EmbeddedSDK[Embedded SDK]
    end
    
    subgraph "Frontend Components"
        NextJSApp[Next.js Application]
        ReactComponents[React Components]
        UILibrary[UI Component Library]
        APIClient[API Client]
    end
    
    subgraph "Backend Components"
        APIGateway[API Gateway]
        AuthService[Authentication Service]
        PanelService[Panel Management Service]
        AppreciationService[Appreciation Service]
        RewardService[Reward Distribution Service]
        NotificationService[Notification Service]
    end
    
    subgraph "Integration Components"
        WarpcastConnector[Warpcast Connector]
        FlowConnector[Flow Blockchain Connector]
        ElizaOSConnector[ElizaOS AI Connector]
    end
    
    subgraph "Data Storage"
        UserDB[(User Database)]
        PanelDB[(Panel Database)]
        AppreciationDB[(Appreciation Database)]
        TransactionDB[(Transaction Database)]
    end
    
    WebApp & MobileApp & EmbeddedSDK -->|Uses| NextJSApp
    NextJSApp -->|Built with| ReactComponents
    ReactComponents -->|Uses| UILibrary
    NextJSApp -->|Communicates via| APIClient
    
    APIClient -->|Requests to| APIGateway
    APIGateway -->|Routes to| AuthService & PanelService & AppreciationService & RewardService & NotificationService
    
    AuthService -->|Integrates with| WarpcastConnector
    AppreciationService -->|Uses| ElizaOSConnector
    AppreciationService & RewardService -->|Use| FlowConnector
    
    AuthService -->|Manages| UserDB
    PanelService -->|Manages| PanelDB
    AppreciationService -->|Manages| AppreciationDB
    RewardService -->|Manages| TransactionDB
```

## Frontend Component Architecture

```mermaid
flowchart TD
    subgraph "Next.js Application"
        Pages[Pages]
        Layouts[Layouts]
        Hooks[Custom Hooks]
        Context[Context Providers]
    end
    
    subgraph "Component Library"
        CoreComponents[Core Components]
        PanelComponents[Panel Components]
        AppreciationComponents[Appreciation Components]
        FormComponents[Form Components]
        UIElements[UI Elements]
    end
    
    subgraph "SDK Components"
        AppreciationList[Appreciation List]
        ThankButton[Thank Button]
        LikeButton[Like Button]
        EmbedPanel[Embed Panel]
    end
    
    subgraph "State Management"
        Redux[Redux Store]
        APISlice[API Slice]
        UserSlice[User Slice]
        PanelSlice[Panel Slice]
    end
    
    Pages -->|Uses| Layouts
    Pages -->|Uses| CoreComponents & PanelComponents & AppreciationComponents
    Pages -->|Uses| Hooks
    Hooks -->|Uses| Context
    
    CoreComponents & PanelComponents & AppreciationComponents -->|Built with| FormComponents & UIElements
    
    AppreciationList & ThankButton & LikeButton & EmbedPanel -->|Uses| CoreComponents & AppreciationComponents
    
    Context -->|Connects to| Redux
    Redux -->|Contains| APISlice & UserSlice & PanelSlice
```

## Backend Service Architecture

```mermaid
flowchart TD
    subgraph "API Gateway"
        Router[API Router]
        Middleware[Middleware Stack]
        RateLimiter[Rate Limiter]
        Logger[Request Logger]
    end
    
    subgraph "Authentication Service"
        AuthController[Auth Controller]
        WarpcastAuth[Warpcast Auth Module]
        JWTManager[JWT Manager]
        UserManager[User Manager]
    end
    
    subgraph "Panel Service"
        PanelController[Panel Controller]
        HashtagManager[Hashtag Manager]
        TemplateManager[Template Manager]
        EmbedManager[Embed Manager]
    end
    
    subgraph "Appreciation Service"
        AckController[Appreciation Controller]
        DetectionManager[Detection Manager]
        TransactionManager[Transaction Manager]
        BlockchainRecorder[Blockchain Recorder]
    end
    
    subgraph "Reward Service"
        RewardController[Reward Controller]
        FeeCollector[Fee Collector]
        SentimentAnalyzer[Sentiment Analyzer]
        DistributionManager[Distribution Manager]
    end
    
    Router -->|Routes to| AuthController & PanelController & AckController & RewardController
    Router -->|Uses| Middleware
    Middleware -->|Includes| RateLimiter & Logger
    
    AuthController -->|Uses| WarpcastAuth & JWTManager & UserManager
    PanelController -->|Uses| HashtagManager & TemplateManager & EmbedManager
    AckController -->|Uses| DetectionManager & TransactionManager & BlockchainRecorder
    RewardController -->|Uses| FeeCollector & SentimentAnalyzer & DistributionManager
```

## ElizaOS AI Agent Architecture

```mermaid
flowchart TD
    subgraph "ElizaOS Agent"
        Listener[Warpcast Listener]
        Parser[Post Parser]
        NLPEngine[NLP Engine]
        SentimentEngine[Sentiment Analysis Engine]
        DecisionEngine[Decision Engine]
        ActionEngine[Action Engine]
    end
    
    subgraph "Integration Points"
        WarpcastAPI[Warpcast API]
        ProtocolAPI[Protocol API]
        BlockchainAPI[Flow Blockchain API]
    end
    
    WarpcastAPI -->|Feeds posts to| Listener
    Listener -->|Extracts content for| Parser
    Parser -->|Provides structured data to| NLPEngine
    NLPEngine -->|Identifies appreciations for| DecisionEngine
    NLPEngine -->|Provides text for| SentimentEngine
    SentimentEngine -->|Provides sentiment scores to| DecisionEngine
    DecisionEngine -->|Triggers| ActionEngine
    ActionEngine -->|Calls| ProtocolAPI
    ActionEngine -->|Initiates transactions via| BlockchainAPI
```

## Flow Blockchain Integration

```mermaid
flowchart TD
    subgraph "Flow Integration"
        FlowSDK[Flow SDK]
        AccountManager[Account Manager]
        ContractManager[Contract Manager]
        TransactionBuilder[Transaction Builder]
        EventListener[Event Listener]
    end
    
    subgraph "Smart Contracts"
        AppreciationContract[Appreciation Contract]
        TokenContract[Token Contract]
        RewardContract[Reward Contract]
    end
    
    subgraph "Protocol Services"
        AckService[Appreciation Service]
        RewardService[Reward Service]
        UserService[User Service]
    end
    
    AckService & RewardService & UserService -->|Use| FlowSDK
    FlowSDK -->|Manages| AccountManager
    FlowSDK -->|Interacts with| ContractManager
    FlowSDK -->|Builds transactions with| TransactionBuilder
    FlowSDK -->|Monitors events with| EventListener
    
    ContractManager -->|Deploys/Calls| AppreciationContract & TokenContract & RewardContract
    EventListener -->|Monitors events from| AppreciationContract & TokenContract & RewardContract
```

## SDK Component Architecture

```mermaid
flowchart TD
    subgraph "Brotea SDK"
        Core[SDK Core]
        Config[Configuration Module]
        Auth[Authentication Module]
        API[API Client]
        UI[UI Components]
    end
    
    subgraph "UI Components"
        AckList[Appreciation List]
        ThankBtn[Thank Button]
        LikeBtn[Like Button]
        PanelEmbed[Panel Embed]
        CustomTheme[Theming System]
    end
    
    subgraph "Integration Methods"
        ReactIntegration[React Integration]
        VanillaJSIntegration[Vanilla JS Integration]
        NPMPackage[NPM Package]
        CDNDistribution[CDN Distribution]
    end
    
    Core -->|Configures| Config
    Core -->|Handles| Auth
    Core -->|Uses| API
    Core -->|Renders| UI
    
    UI -->|Includes| AckList & ThankBtn & LikeBtn & PanelEmbed
    UI -->|Supports| CustomTheme
    
    ReactIntegration & VanillaJSIntegration -->|Use| Core
    NPMPackage & CDNDistribution -->|Package| Core & UI
```

## Data Flow Architecture

```mermaid
flowchart TD
    subgraph "Data Sources"
        WarpcastPosts[(Warpcast Posts)]
        UserActions[(User Actions)]
        BlockchainEvents[(Blockchain Events)]
        AIAnalysis[(AI Analysis Results)]
    end
    
    subgraph "Data Processing"
        EventCapture[Event Capture System]
        DataTransformer[Data Transformer]
        BusinessLogic[Business Logic Layer]
        ValidationLayer[Validation Layer]
    end
    
    subgraph "Data Storage"
        RelationalDB[(Relational Database)]
        BlockchainStorage[(Blockchain Storage)]
        CacheLayer[(Cache Layer)]
        AnalyticsStore[(Analytics Store)]
    end
    
    subgraph "Data Consumption"
        APIEndpoints[API Endpoints]
        WebhookSystem[Webhook System]
        ReportingEngine[Reporting Engine]
        ClientSDK[Client SDK]
    end
    
    WarpcastPosts & UserActions & BlockchainEvents & AIAnalysis -->|Feed into| EventCapture
    EventCapture -->|Processes with| DataTransformer
    DataTransformer -->|Applies| BusinessLogic
    BusinessLogic -->|Validates through| ValidationLayer
    
    ValidationLayer -->|Stores in| RelationalDB & BlockchainStorage
    RelationalDB & BlockchainStorage -->|Cached in| CacheLayer
    RelationalDB & BlockchainStorage -->|Analyzed in| AnalyticsStore
    
    CacheLayer & RelationalDB -->|Exposed via| APIEndpoints
    BlockchainStorage & AnalyticsStore -->|Triggers| WebhookSystem
    AnalyticsStore -->|Feeds| ReportingEngine
    APIEndpoints -->|Consumed by| ClientSDK
```

## Deployment Architecture

```mermaid
flowchart TD
    subgraph "Development Environment"
        LocalDev[Local Development]
        TestEnv[Testing Environment]
        StagingEnv[Staging Environment]
    end
    
    subgraph "CI/CD Pipeline"
        GitRepo[Git Repository]
        BuildSystem[Build System]
        TestRunner[Test Runner]
        DeploymentManager[Deployment Manager]
    end
    
    subgraph "Production Environment"
        WebServers[Web Servers]
        APIServers[API Servers]
        DatabaseServers[Database Servers]
        AIServices[AI Services]
    end
    
    subgraph "External Services"
        FlowNetwork[Flow Network]
        WarpcastAPI[Warpcast API]
        MonitoringServices[Monitoring Services]
    end
    
    LocalDev & TestEnv & StagingEnv -->|Commit to| GitRepo
    GitRepo -->|Triggers| BuildSystem
    BuildSystem -->|Runs| TestRunner
    TestRunner -->|If successful, triggers| DeploymentManager
    
    DeploymentManager -->|Deploys to| WebServers & APIServers & DatabaseServers & AIServices
    
    WebServers & APIServers -->|Interact with| FlowNetwork & WarpcastAPI
    WebServers & APIServers & DatabaseServers & AIServices -->|Monitored by| MonitoringServices
