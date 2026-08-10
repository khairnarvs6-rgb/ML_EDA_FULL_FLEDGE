```makefile
.PHONY: help venv install data features train predict reports pipeline all api test lint format clean docker-build

# ============================================================
# Project Configuration
# ============================================================

PROJECT_NAME := ml-eda-full-fledge
PYTHON := python

# ============================================================
# Virtual Environment
# ============================================================

ifeq ($(OS),Windows_NT)
	VENV_PYTHON := .venv/Scripts/python.exe
	VENV_PIP := .venv/Scripts/pip.exe
else
	VENV_PYTHON := .venv/bin/python
	VENV_PIP := .venv/bin/pip
endif


# ============================================================
# Help
# ============================================================

help:
	@echo "ML EDA Full Fledge"
	@echo ""
	@echo "Environment:"
	@echo "  make venv          Create virtual environment"
	@echo "  make install       Install dependencies"
	@echo ""
	@echo "ML Pipeline:"
	@echo "  make data          Run dataset processing"
	@echo "  make features      Run feature engineering"
	@echo "  make train         Train ML model"
	@echo "  make predict       Generate predictions"
	@echo "  make reports       Generate reports"
	@echo "  make pipeline      Run complete ML pipeline"
	@echo ""
	@echo "Quality:"
	@echo "  make test          Run pytest"
	@echo "  make lint          Run Ruff"
	@echo "  make format        Format source code"
	@echo ""
	@echo "Application:"
	@echo "  make api           Run API"
	@echo ""
	@echo "Docker:"
	@echo "  make docker-build  Build Docker image"
	@echo ""
	@echo "Cleanup:"
	@echo "  make clean         Remove Python cache files"


# ============================================================
# Virtual Environment
# ============================================================

venv:
	$(PYTHON) -m venv .venv
	$(VENV_PYTHON) -m pip install --upgrade pip


# ============================================================
# Install Dependencies
# ============================================================

install:
	$(VENV_PYTHON) -m pip install --upgrade pip
	$(VENV_PYTHON) -m pip install -r requirements.txt
	$(VENV_PYTHON) -m pip install pytest ruff


# ============================================================
# Dataset
# ============================================================

data:
	$(VENV_PYTHON) -m src.dataset


# ============================================================
# Feature Engineering
# ============================================================

features:
	$(VENV_PYTHON) -m src.features


# ============================================================
# Model Training
# ============================================================

train:
	$(VENV_PYTHON) -m src.train


# ============================================================
# Prediction
# ============================================================

predict:
	$(VENV_PYTHON) -m src.predict


# ============================================================
# Reports
# ============================================================

reports:
	$(VENV_PYTHON) -m src.reports


# ============================================================
# Complete ML Pipeline
# ============================================================

pipeline: data features train predict reports


# Alias for pipeline
all: pipeline


# ============================================================
# API
# ============================================================

api:
	$(VENV_PYTHON) -m src.api


# ============================================================
# Testing
# ============================================================

test:
	$(VENV_PYTHON) -m pytest tests/ -v


# ============================================================
# Linting
# ============================================================

lint:
	$(VENV_PYTHON) -m ruff check src/ tests/


# ============================================================
# Formatting
# ============================================================

format:
	$(VENV_PYTHON) -m ruff format src/ tests/


# ============================================================
# Docker
# ============================================================

docker-build:
	docker build -t $(PROJECT_NAME):latest .


# ============================================================
# Cleanup
# ============================================================

clean:
	$(PYTHON) -c "import pathlib; [p.unlink() for p in pathlib.Path('.').rglob('*.pyc') if p.is_file()]"
	$(PYTHON) -c "import pathlib, shutil; [shutil.rmtree(p) for p in pathlib.Path('.').rglob('__pycache__') if p.is_dir()]"
```
