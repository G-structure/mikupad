# Repository Guidelines

## Project Structure & Module Organization
- `mikupad.html`: Source HTML for the web app (React + htm).
- `mikupad.css`: Base stylesheet linked from `mikupad.html`.
- `mikupad.js`: React logic and components.
- `importmap.json`: Module map resolving external dependencies.
- `project/`: Parcel project wrapper; `package.json` with `start`/`build`.
- `server/`: Express + SQLite API and proxy; `server.js`, `start.sh|.bat`.
- `compile.sh|.bat`: Bundles `mikupad.html`/`mikupad.css`/`mikupad.js` into `mikupad_compiled.html`, `mikupad_compiled.css`, and `mikupad_compiled.js`.
- `.github/workflows/`: Release workflow that compiles on push to `main`.

## Build, Test, and Development Commands
- Run locally (no server): `open mikupad.html` (or double‑click).
- Build compiled HTML: `./compile.sh` (Windows: `compile.bat`).
- Parcel build (manual): `cd project && npm install && npm run build`.
- Start server: `cd server && npm install --no-audit && node server.js`.
  - Flags/env: `--port 3000 --host 0.0.0.0 --open=false` or `MIKUPAD_PORT`, `MIKUPAD_HOST`, `MIKUPAD_NO_OPEN=1`, `MIKUPAD_LOGIN`, `MIKUPAD_PASSWORD`.

## Coding Style & Naming Conventions
- JavaScript: 4‑space indent, semicolons, single quotes, trailing commas where safe.
- React: `PascalCase` components, `camelCase` props/variables, small pure functions.
- Files: scripts in `kebab-case`, keep server code in `server/`, build logic in `project/`.
- Shell: keep scripts idempotent; check `node`/`npm` availability like existing scripts.

## Testing Guidelines
- No formal test suite yet. Do smoke tests:
  - Frontend: open `mikupad.html` and exercise key flows (prompt, generate, save/load session).
  - Server: run `cd server && node server.js`, then probe `GET /version`, `POST /save`, `POST /load` with `curl` or Postman.
- If adding tests, prefer lightweight Jest for JS modules and Playwright for basic UI flows.

## Commit & Pull Request Guidelines
- Commits: imperative, concise subject (≤72 chars). Example: `feat(server): add /sessions listing`.
- PRs: include a clear description, linked issues, and screenshots for UI changes. Note any server/API changes and manual test steps.
- Build: ensure `./compile.sh` succeeds locally; CI will compile on `main` and attach `mikupad_compiled.html` to the release.
- Do not commit generated `mikupad_compiled.*` artifacts; they are built for releases.

## Security & Configuration Tips
- Protect the server with `MIKUPAD_LOGIN`/`MIKUPAD_PASSWORD` when exposing beyond localhost.
- Do not commit secrets or private endpoints. Keep SQLite files out of VCS.
- Use `MIKUPAD_PORT`/`MIKUPAD_HOST` to bind appropriately in containers/VMs.

