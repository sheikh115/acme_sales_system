# Acme Sales System

This project implements an e-commerce shopping basket system that supports product catalogues, promotional offers, and tiered delivery rules.

## Features

- Product Catalogue: Allows you to manage products by code.

- Basket: Add products, calculate total price including offers and delivery cost.

- Delivery Rules: Apply tiered delivery costs based on subtotal.

- Offers: Apply promotional offers like "Buy One, Get One Half Price" & Seasonal percentage discounts.

## Assumptions

- Only one or no offer can be applied on a basket
- Offers are calculated based on the total product price (before delivery charges). This means any promotions or discounts, such as "Buy One, Get One Free" or "50% off", are applied to the product total first.

## How It Works
1. Catalogue & Products

- The catalogue contains a set of products, each with a unique code, name, and price.

- The Product class holds the details for each product, while the Catalogue class manages a collection of products and allows retrieving products by their codes and fetch prices of product

2. Adding Items to the Basket

- Products are added to the basket by the product's code (e.g., R01, G01, etc.).

- The system checks if the product code exists in the catalogue. If not, it raises an error with a message.


3. Offers & Discounts

- The system supports applying promotional offers to the items in the basket.

- Offers are implemented as classes that inherit from an abstract Offer class.

- For example, the Buy one get second half class implements a buy one, Get the Second Half Price" offer. Assumes both product in the basket should be of the same code.

- Offers are applied after all items have been added to the basket, and they reduce the subtotal before delivery charges are applied.

4. Delivery Rules

- Delivery costs are calculated based on the subtotal (after offers have been applied).

- The StandardDeliveryRule class contains tiered pricing:

- Orders under $50 incur a $4.95 delivery fee.

- Orders between $50 and $90 incur a $2.95 delivery fee.

- Orders over $90 incur free delivery.

- The delivery cost is added to the subtotal after applying any applicable offers.

5. Total Calculation

- The total method calculates the total cost by:

- Adding up the prices of all items in the basket.

- Subtracting any applicable offer discounts.

- Adding the delivery cost based on the subtotal.

- Rounding the final result to two decimal places to ensure precision (for monetary values).

6. Extensibility

- The system is designed to be easily extensible. New products, offers, or delivery rules can be added without modifying the core logic of the basket.

- Products can be added to the Catalogue with a unique code, name, and price.

- Offers can be created by subclassing the Offer class and implementing the apply method.

## To start

```
ruby main.rb
```


## To Run Tests

```
rake test
```