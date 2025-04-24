
<h1 align="center">KanbanApp</h1>

<p align="center">
  Aplicativo iOS (open-source) que leva para o seu bolso o
  <strong>quadro Kanban e o painel financeiro</strong> usados pela
  <em>AHR Soluções LTDA</em>.  
  Totalmente sincronizado, em tempo-real, com o back-end PHP <br/>
  já utilizado na versão web.
  <br><br>
  <img alt="Swift Version" src="https://img.shields.io/badge/swift-5.10-orange">
  <img alt="iOS Minimum"  src="https://img.shields.io/badge/iOS-16+-brightgreen">
  <img alt="License"      src="https://img.shields.io/github/license/psaderr/KanbanApp">
  <img alt="Build"        src="https://img.shields.io/github/actions/workflow/status/psaderr/KanbanApp/ci.yml?label=CI">
</p>

---

## ✨ Principais Funcionalidades

| Tela | Descrição |
|------|-----------|
| **Quadro Kanban** | Arraste cartões entre colunas; criação/edição inline; filtros por data, usuário e status. |
| **Painel Financeiro** | Fluxo de caixa diário/semanal/mensal, gráficos de barras e pizza, lançamentos com categorias. |
| **Notificações Push** | Informa em tempo real sobre novas tarefas, movimentações e vencimentos financeiros. |
| **Modo Offline** | Cache inteligente com Core Data → continua funcionando sem internet; sincroniza depois. |
| **Acessibilidade** | Dynamic Type, VoiceOver e esquema de cores compatível com alto contraste. |

---

## 🏗️ Tech Stack

| Camada | Tecnologias |
|--------|-------------|
| Linguagem | **Swift 5.10**, Swift Concurrency |
| UI      | **SwiftUI 3**, Combine, SF Symbols |
| Persistência | Core Data + CodableCache |
| Sincronização | RESTful API (PHP/MySQL) + URLSession + async/await |
| Notificações | Firebase Cloud Messaging |
| DevOps | GitHub Actions (CI), Fastlane, TestFlight |

---

## ⚙️ Requisitos

| Ferramenta | Versão mínima |
|------------|---------------|
| macOS      | 13 Ventura |
| Xcode      | 15.3 |
| Swift      | 5.10 (incluído no Xcode) |
| Cocoapods¹ | 1.14<br>*(apenas se você optar por Pods)* |
| VS Code²   | 1.90+ |

> **¹** O projeto usa SPM por padrão; Cocoapods só é necessário para bibliotecas extras opcionais.  
> **²** Se você preferir VS Code em vez de Xcode, siga o guia abaixo.

---

## 🚀 Execução Rápida

### Com Xcode

```bash
git clone https://github.com/psaderr/KanbanApp.git
cd KanbanApp
open KanbanApp.xcodeproj    # ou .xcworkspace se tiver Pods
# Selecione o esquema ▸ iPhone 15 Pro (ou seu dispositivo) ▸ ⌘R
