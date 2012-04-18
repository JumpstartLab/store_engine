---
layout: page
title: StoreEngine Evaluation Story 4
---

## Shopper Does Bad Things

* Feature: Shopper Does Bad Things
    * Background:
        * Given I am logged in as "demo09+matt@jumpstartlab.com"
        * And I have purchased the product Aquaphor Baby Gentle Wash
    * Scenario: Admin creates product
        * Given the product Aquaphor Baby Gentle Wash has been retired
        * When I view my previous order with Aquaphor Baby Gentle Wash
        * And I view the product Aquaphor Baby Gentle Wash
        * Then I should see it is retired
        * When I add it to my cart
        * Then I should be told I can't add it to my cart
        * And it should not appear in my cart
    * Scenario: Admin creates category
        * Given I view my previous order with <purchased product name>
        * And I remember the URL of the page
        * And I log out
        * When I try to visit the previous order page
        * Then I should see a 404 or other error message
        * And I should not be viewing the previous order
