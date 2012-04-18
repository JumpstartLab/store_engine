---
layout: page
title: StoreEngine Evaluation Story 2
---

## Adding Products To The Cart From Multiple Sources

* Feature: Adding Products To The Cart From Multiple Sources
    * Background:
        * Given I am logged in as "demo09+matt@jumpstartlab.com"
        * And I have previously purchased the product <Aquaphor Baby Gentle Wash>
    * Scenario: Viewing products by category
        * Given I view the products in the category <Snacks>
        * Then I should see a list of products all in the category <Snacks>
    * Scenario: Viewing details for a product
        * Given I view the products in the category <Snacks>
        * When I click on the product <Green and Blacks Dark 85% Chocolate Bar>
        * Then I should see the product details
        * And I should see "add to cart"
    * Scenario: Adding to cart
        * Given I am viewing the product <Green and Blacks Dark 85% Chocolate Bar> from category <Snacks>
        * When I click "add to cart"
        * Then I should see my cart
        * And my cart should contain <Green and Blacks Dark 85% Chocolate Bar> with quantity 1
    * Scenario: Viewing previous orders
        * Given I have added the product <Green and Blacks Dark 85% Chocolate Bar> to my cart
        * When I view my previous orders
        * And I choose the order containing <Aquaphor Baby Gentle Wash>
        * And I view the product <Aquaphor Baby Gentle Wash>
        * And I add it to my cart
        * Then my cart should contain <Green and Blacks Dark 85% Chocolate Bar> with quantity 1
        * And my cart should contain <Aquaphor Baby Gentle Wash> with quantity 1
