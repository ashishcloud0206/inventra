# INVENTRA - Scrum Call Preparation Document

**Project:** Inventra - AI-Powered Inventory & Financial Management System
**Launch Date:** February 1, 2026
**Environment:** Python 3.10 Conda | Streamlit 1.40.2 | LangGraph 0.2.45
**Status:** ✅ Successfully Running (http://localhost:8501)

---

## 1. WHAT IS INVENTRA? (60 seconds pitch)

Inventra is an **intelligent multi-agent AI system** that helps businesses manage inventory, finances, and make data-driven decisions. It combines:
- **Gemini AI** (LangChain) for smart recommendations
- **LangGraph** for orchestrated agent workflows
- **Real-time weather integration** for demand forecasting
- **Interactive Streamlit Dashboard** for visualization

**Use Case:** A warehouse/retail company asks "Show me low-stock items in North region" or "What should I reorder for monsoon season?" and gets AI-powered recommendations backed by historical data + weather patterns.

---

## 2. ARCHITECTURE & COMPONENTS OVERVIEW

### 2.1 Multi-Agent Workflow (4 Nodes)
```
User Query
    ↓
[1] CLASSIFY INTENT (Gemini LLM)
    ↓ (determines: inventory_status, sales_analysis, reorder_recommendation, etc.)
[2] GATHER DATA (Report Agent)
    ↓ (pulls from SQLite database)
[3] DECIDE (Decision Agent + AI)
    ↓ (optional - runs only for complex decisions)
[4] RESPOND (Format & return to user)
```

### 2.2 Core Modules

| Module | Purpose | Tech Stack |
|--------|---------|-----------|
| **agents/coordinator.py** | LangGraph orchestration (341 lines) | LangGraph + Gemini |
| **agents/decision_agent.py** | AI recommendations & analysis (430 lines) | Gemini AI + LLM agents |
| **agents/report_agent.py** | Data aggregation & reporting (360 lines) | Pandas + SQLite |
| **ui/streamlit_app.py** | Interactive web dashboard | Streamlit |
| **database/db_manager.py** | SQLite connection & ORM | SQLAlchemy |
| **services/data_pipeline.py** | Data caching & aggregation | Pandas |
| **tools/weather.py** | OpenWeather API integration | Requests |
| **tools/finance.py** | Financial calculations | SQLAlchemy queries |
| **config/settings.py** | Env-based configuration | Pydantic |

---

## 3. DATABASE & DATA

### 3.1 Database Schema (Pre-populated)
**Location:** `./database/inventra.db` (SQLite, 936 KB)

**Tables:**
- **inventory** (100 items) - SKU, name, qty, category, region, reorder_threshold
- **sales** (9,157 transactions) - Date range: 2019-2024, quantity, revenue
- **financial** (5,000 records) - Sales/purchases, profit/loss by region
- **vendors** (20 profiles) - Quality score, reliability rating, lead_time_days
- **tickets** (0 initial) - Auto-generated for restocking needs
- **forecasts** (0 initial) - Weather-based demand predictions

**Regions:** North, South, East, West, Central
**Categories:** Electronics, Kitchen Appliances, Home Appliances, Lighting, Home Care

### 3.2 Data Files
- `data/inventory.csv` – Item master
- `data/sales.csv` – Transaction history
- `data/finance.csv` – Financial records
- `data/vendors.csv` – Vendor profiles

---

## 4. REQUIRED API KEYS (PRODUCTION CHECKLIST)

### 4.1 CRITICAL (App Won't Run Without These)
| Key | Provider | Value | Status |
|-----|----------|-------|--------|
| **GEMINI_API_KEY** | Google AI Studio | `AIzaSyCPgyHO68fvJ8yNB__XNBLnp-v9hcUXa_E` | ✅ Configured |
| **OPENWEATHER_API_KEY** | OpenWeatherMap | `56c11bbd0939c9b5d0d37ec63425890f` | ✅ Configured |

**Limits:**
- Gemini: 60 req/min, 1M tokens/day (Free)
- OpenWeather: 60 calls/min, 1M/month (Free)

### 4.2 OPTIONAL
| Key | Purpose | Status |
|-----|---------|--------|
| HUGGINGFACE_API_TOKEN | MCP sentiment analysis | ⏳ Optional |

### 4.3 How to Obtain Keys

**Google Gemini API:**
1. Visit https://makersuite.google.com/app/apikey
2. Sign in → Click "Create API Key"
3. Copy key (starts with `AIza...`)

**OpenWeather API:**
1. Visit https://openweathermap.org/api
2. Sign up → Dashboard → "My API Keys"
3. Copy default key

---

## 5. HOW TO RUN (3 Modes)

### 5.1 WEB INTERFACE (Recommended - Currently Running ✅)
```powershell
cd c:\Users\aktiwari\Downloads\Inventera\Inventera\GenAI-Live-Course-Project-5-Intelligent-Financial-and-Inventory-Management-main
conda activate inventera310
python main.py web
```
**Access:** `http://localhost:8501`

**Features:**
- Interactive queries via text input
- Real-time agent response streaming
- Dashboard with statistics & visualizations
- Export reports to CSV/JSON/Excel

### 5.2 CLI MODE
```powershell
python main.py cli
```
**Features:**
- Command-line interface
- Chat-like interaction
- Keyboard interrupt (Ctrl+C) to exit

### 5.3 QUICK STATS
```powershell
python main.py stats
```
**Output:**
- Inventory summary (low-stock count)
- Sales metrics (30 days)
- Financial summary (90 days)
- Pending ticket count

---

## 6. SAMPLE USER QUERIES (Test Cases)

Try these in the Streamlit app:

| Query | Agent Path | Expected Result |
|-------|-----------|-----------------|
| "Show me the financial summary" | Classify → Gather Financial → Respond | Profit/loss by region |
| "What items are low in stock?" | Classify → Gather Inventory → Respond | Low-stock item list |
| "Give me sales analysis for North region" | Classify → Gather Sales + Region filter | Regional sales trends |
| "What should I reorder for monsoon season?" | Classify → Gather + **Decide (AI)** + Weather | AI recommendations + suggested qty |
| "Show pending tickets" | Classify → Gather Tickets → Respond | Open vendor tickets |
| "Optimize vendor selection for electronics" | Classify → Gather + **Decide (Vendor Opt)** | Top 3 vendors ranked |

---

## 7. DEPENDENCIES & ENVIRONMENT

### 7.1 Environment Details
- **OS:** Windows PowerShell
- **Conda Env:** `inventera310` (Python 3.10.19)
- **Python Version:** 3.10 (required for compatibility)
- **Conda Path:** `C:\ProgramData\anaconda3`

### 7.2 Key Dependencies
```
langchain==0.3.7                    # LLM orchestration
langchain-google-genai==2.0.5       # Gemini integration
langgraph==0.2.45                   # Multi-agent workflow
streamlit==1.40.2                   # Web UI
pandas==2.2.3                       # Data processing
pydantic==2.10.3                    # Config validation
python-dotenv==1.0.1                # Env file loading
mcp==1.1.2                          # Model Context Protocol
httpx==0.27.2                       # HTTP client
```

**Note:** `langchain-mcp` version bumped from 0.1.2 → 0.2.1 (incompatible distribution fixed).

### 7.3 Installation Command
```powershell
conda run -n inventera310 python -m pip install -r requirements.txt
```

---

## 8. CONFIGURATION (.env)

### 8.1 Current .env Setup
```env
GEMINI_API_KEY=AIzaSyCPgyHO68fvJ8yNB__XNBLnp-v9hcUXa_E
GEMINI_MODEL=gemini-2.5-flash
OPENWEATHER_API_KEY=56c11bbd0939c9b5d0d37ec63425890f
OPENWEATHER_BASE_URL=https://api.openweathermap.org/data/2.5
DATABASE_PATH=./database/inventra.db
LOG_LEVEL=INFO
WEATHER_CACHE_TTL=1800
MAX_CONVERSATION_HISTORY=10
```

### 8.2 Production Deployment Notes
- **Secrets Management:** Store API keys in AWS Secrets Manager / Azure Key Vault (NOT in Git)
- **Database:** Consider PostgreSQL for multi-user access (instead of SQLite)
- **Load Balancer:** Deploy Streamlit on Kubernetes / Docker for scaling
- **Auth:** Add OAuth2 / AD integration for enterprise
- **Monitoring:** Enable CloudWatch / Datadog for error tracking

---

## 9. STEP-BY-STEP FLOW EXPLANATION

### 9.1 User Asks: "What should I reorder for monsoon season?"

```
Step 1: CLASSIFY INTENT
├─ Gemini LLM reads query
├─ Determines intent: "reorder_recommendation"
├─ Extracts: region=None, category=None, sku=None
└─ Logs: "Classified intent: reorder_recommendation"

Step 2: GATHER DATA
├─ Report Agent queries SQLite:
│  ├─ SELECT * FROM inventory WHERE qty < reorder_threshold
│  ├─ Counts low-stock items per category
│  └─ Retrieves region summary
└─ Returns: {"low_stock_items": [...], "low_stock_count": 8, ...}

Step 3: DECIDE (Decision Agent)
├─ Calls analyze_inventory_needs() function
├─ Decision Agent LLM:
│  ├─ Reads low-stock data
│  ├─ Calls get_weather_forecast_tool() → OpenWeather API
│  ├─ Analyzes: "Monsoon → increased demand for kitchen appliances"
│  ├─ Cross-references with vendor performance
│  └─ LLM generates recommendation text
└─ Returns: {"region": None, "analysis": "Recommend restocking...", ...}

Step 4: RESPOND (Format)
├─ Takes decision output
├─ Formats for user readability
└─ Returns to Streamlit UI
```

### 9.2 Agent Communication Flow Diagram
```
User Query
    ↓
coordinator.py::process_query()
    ├─ Creates AgentState
    ├─ Invokes LangGraph StateGraph
    │  ├─ Node 1: classify_intent()
    │  │  └─ Calls: ChatGoogleGenerativeAI.invoke()
    │  ├─ Node 2: gather_data()
    │  │  └─ Calls: Report Agent (get_inventory_status, etc.)
    │  ├─ Node 3: make_decision()
    │  │  └─ Calls: Decision Agent (analyze_*, weather tools)
    │  └─ Node 4: respond()
    │     └─ Formats final response
    └─ Returns final_response
        ↓
    Streamlit UI / CLI Display
```

---

## 10. SCRUM DISCUSSION TALKING POINTS

### 10.1 Technical Achievements
✅ **Multi-agent architecture** – LangGraph orchestration decouples concerns  
✅ **Real-time weather integration** – Weather API + LLM reasoning for demand forecasting  
✅ **Pre-seeded database** – 100 inventory items + 9K sales transactions enable immediate testing  
✅ **Modular design** – Easy to swap LLM providers or add new agents  
✅ **Export capabilities** – CSV/JSON/Excel reports for stakeholder sharing  

### 10.2 Known Limitations & Mitigation
⚠️ **Single SQLite DB** → Plan: Migrate to PostgreSQL for concurrency  
⚠️ **Free-tier API limits** → Plan: Implement request caching + rate-limiting  
⚠️ **Weather data 30-min cache** → Plan: Configurable TTL per deployment environment  
⚠️ **Streamlit scalability** → Plan: Containerize & deploy on Kubernetes  

### 10.3 Deployment Roadmap
- **Phase 1 (Current):** Local development + manual testing ✅
- **Phase 2:** Docker containerization + Docker Compose for multi-service setup
- **Phase 3:** AWS deployment (RDS PostgreSQL + ECS for Streamlit)
- **Phase 4:** CI/CD pipeline (GitHub Actions) + automated test suite
- **Phase 5:** User auth + RBAC (role-based access control)

### 10.4 Questions for Stakeholders
1. **Scope:** Should the system support real-time inventory updates from retail POS?
2. **Data:** Do we need historical data beyond October 2024? (Currently 2019-2024)
3. **Integration:** Should vendor APIs (purchase orders) be automated?
4. **Security:** Do we need SOC 2 compliance for enterprise customers?
5. **Licensing:** Which LLM provider long-term? (Gemini free tier → OpenAI / Anthropic?)

---

## 11. TROUBLESHOOTING

### Issue: "ImportError: cannot import name 'AgentExecutor'"
**Cause:** langchain API version mismatch (v0.3.x changed agent interfaces)  
**Fix:** Ensure Python 3.10 + requirements.txt installed:
```powershell
conda run -n inventera310 python -m pip install -r requirements.txt
```

### Issue: "No such file or directory: .env"
**Cause:** Missing `.env` file in project root  
**Fix:** Copy `.env.example` → `.env` and populate API keys

### Issue: "GEMINI_API_KEY not found"
**Cause:** API key not in `.env` or invalid format  
**Fix:** Check that `.env` contains `GEMINI_API_KEY=AIza...` (not `AIZA SyCPgyHO...` with typo)

### Issue: Streamlit port 8501 already in use
**Fix:**
```powershell
streamlit run ui/streamlit_app.py --server.port 8502
```

---

## 12. KEY FILES & THEIR ROLES

| File | Lines | Purpose |
|------|-------|---------|
| main.py | 133 | CLI entry point (web/cli/stats modes) |
| agents/coordinator.py | 341 | LangGraph orchestration |
| agents/decision_agent.py | 430 | AI decision-making |
| agents/report_agent.py | 360 | Data gathering & reporting |
| ui/streamlit_app.py | TBD | Web dashboard UI |
| database/db_manager.py | TBD | SQLite ORM layer |
| config/settings.py | 40 | Pydantic config + env parsing |
| services/data_pipeline.py | TBD | Caching & aggregation |
| tools/weather.py | TBD | OpenWeather API wrapper |
| tools/finance.py | TBD | Financial analysis tools |

---

## 13. NEXT STEPS (IMMEDIATE)

1. **Test Coverage:** Add unit tests for decision_agent & coordinator nodes
2. **Database Migration:** Design PostgreSQL schema for prod deployment
3. **API Stability:** Implement request retry logic + circuit breaker for weather API
4. **Security Audit:** Review env var handling, SQL injection risks, API key exposure
5. **Performance:** Profile LangGraph execution times, optimize query caching

---

## 14. CONTACT & SUPPORT

**Launched:** 2026-02-01 | **Conda Env:** inventera310 | **Status:** ✅ Running  
**Streamlit URL:** http://localhost:8501  
**Database:** `./database/inventra.db` (936 KB, pre-seeded)  
**Config:** `.env` (API keys configured)

---

**Document Prepared For:** Scrum Call Discussion  
**Last Updated:** 2026-02-01  
**Next Review:** Post-deployment phase
