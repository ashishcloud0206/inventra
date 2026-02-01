@echo off
REM Batch file to run Streamlit with conda environment
cd /d "c:\Users\aktiwari\Downloads\Inventera\Inventera\GenAI-Live-Course-Project-5-Intelligent-Financial-and-Inventory-Management-main"
call C:\ProgramData\anaconda3\Scripts\activate.bat inventera310
streamlit run ui/streamlit_app.py
pause
