# 🛍️ Flutter E-Commerce UI App

## 📱 App Preview

<div style="display: flex; flex-direction: row; gap: 40px; margin: 20px 0;">

  <div style="display: flex; flex-direction: column; gap: 16px; align-items: center;">
    <img src="./screenshots/home.png" alt="Home Screen" style="width: 200px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
    <p style="margin-top: 8px; font-size: 0.9em;">Home Screen</p>
  </div>

  <div style="display: flex; flex-direction: column; gap: 16px; align-items: center;">
    <img src="./screenshots/search.png" alt="Search Screen" style="width: 200px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
    <p style="margin-top: 8px; font-size: 0.9em;">Search Screen</p>
  </div>

  <div style="display: flex; flex-direction: column; gap: 16px; align-items: center;">
    <img src="./screenshots/details.png" alt="Details Screen" style="width: 200px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
    <p style="margin-top: 8px; font-size: 0.9em;">Details Screen</p>
  </div>

  <div style="display: flex; flex-direction: column; gap: 16px; align-items: center;">
    <img src="./screenshots/add.png" alt="Add Product Screen" style="width: 200px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
    <p style="margin-top: 8px; font-size: 0.9em;">Add Product</p>
  </div>

</div>

---

## 📝 Description

A modern, scalable Flutter e-commerce app built using **Clean Architecture** and **TDD (Test-Driven Development)** principles.

### ✨ Features
- **Browse Products** in a responsive grid layout
- **Filter/Search Products** by name, price range
- **Product Details** with descriptions, price, and image
- **Add New Products** via a form with validation
- **Domain-layer logic** using Clean Architecture and use cases

---

## 🧱 Architecture

This app follows **Clean Architecture**, with 3 major layers:

```bash
lib/
├── core/                # shared error handling, base classes, and utilities
├── features/
│   └── product/
│       ├── domain/      # entities, repositories, and use cases
│       ├── data/        # models and data sources
│       └── presentation/# UI screens and widgets
