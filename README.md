# 🧺 ACME Widget Checkout

A simple Ruby-based basket checkout system that calculates item totals, delivery charges, and applies promotional offers.

## 📦 Features

- Add products to a virtual shopping basket
- Calculate subtotal, delivery, discounts, and total
- Pluggable offers (currently implements "Buy One Get Second Half Price")
- Support for customizable delivery rules
- Tiered delivery pricing based on order value
- Invoice generation with formatted output

## 🔧 Requirements

- Ruby 3.2.0 or later
- Bundler (`gem install bundler` if not already installed)

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/abiha-aftab/acme-widget-checkout.git
cd acme-widget-checkout
```

### 2. Install Dependencies

```bash
bundle install
```

### 3. Run the Demo

```bash
ruby setup.rb
```

This will display 4 example baskets with their calculated totals.

### 4. Running the Test Suite

```bash
bundle exec rspec
```

## ✨ Design Approach

### Object-Oriented Design

- **Basket**: Maintains a list of items and calculates totals with offers and delivery
- **Product**: Represents each purchasable item with code, name, and price
- **Offers**: Encapsulated as pluggable rules (e.g., BuyOneGetSecondHalfPrice)
- **DeliveryCalculator**: Handles delivery fee logic based on subtotal
- **DeliveryRule**: Defines delivery pricing rules based on threshold and charge
- **Invoice**: Formats and displays basket totals as an invoice

### Extendability

- Easily add new offer types by implementing an `#apply(items)` method on the Offer base class
- Delivery rules and pricing strategies are decoupled from core basket logic
- Simple interface for adding new product types and delivery tiers

### Dependency Injection

- Basket gets injected with offers, delivery calculator, and product catalog
- Promotes testability and flexibility
- Clear separation of concerns


