setup-dev:
	pip install -U pre-commit==2.15.0
	pre-commit install

setup-trunk:
	trunk git-hooks sync
