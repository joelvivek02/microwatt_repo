# Custom AI/ML Accelerator Companion for Microwatt

## Overview
This project explores how the Microwatt POWER CPU core can be extended with a **custom AI/ML accelerator**.  
The goal is to demonstrate that even a lightweight soft CPU can benefit from dedicated hardware support for matrix computations, enabling **faster inference for small machine learning workloads**. Instead of running all ML computations in software, Microwatt will offload selected operations (e.g., **matrix–vector multiplication**) to a custom accelerator connected via a **memory-mapped interface**.  

## Implementation Plan

This project will be implemented in **six steps** within the one-month challenge timeframe (5 hours/week).  


### Step 1. Setup Environment (Week 1)  
### Step 2. Define Accelerator Interface (Week 1)
### Step 3. Implement Accelerator (Week 2)
### Step 4. Write C Driver & Test Code (Week 3)
### Step 5. Validate in Simulation (Week 3–4) 


**Summary:**  
The workflow is:  
**Simulation first → Add accelerator → Write C driver → Compare results → Document → Submit.**
