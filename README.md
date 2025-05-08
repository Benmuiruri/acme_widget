# Acme Widget Co Sales System

This is a Ruby CLI tool for the Acme Widget Co sales system. It calculates the total cost of a basket of items, taking into account delivery charges and special offers.

## Features

- Product catalog management
- Configurable delivery charge rules
- Extensible promotional offer system
- Interactive CLI interface

## Installation

1. Clone the repository - `git clone https://github.com/yourusername/acme_widget.git`
2. install dependencies - `bundle install`

## How to Run

# Interactive CLI Mode
`./bin/acme_widget`

This will start the interactive CLI application where you can add products to your basket, view the basket contents, and clear the basket.

## Runnning tests

`bundle exec rspec`

## Assumptions
- Delivery charges are calculated based on the basket total after discounts.
- The "buy one, get second half price" offer applies to multiples of two items (e.g., with 3 items, the discount applies to 1 item)
