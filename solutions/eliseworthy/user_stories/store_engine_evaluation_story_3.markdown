---
layout: page
title: StoreEngine Evaluation Story 3
---

## Admin Puts Product Through Lifecycle

* Feature: Admin Puts Product Through Lifecycle
    * Background:
        * Given I am logged in as "demo09+chad@jumpstartlab.com"
        * And I am viewing the admin area of the store
    * Scenario: Admin creates product
        * Given I click the add product link/button
        * And I fill in the fields with <Curls Patty Cake Baby Curl Conditioner>, <Derived from coconut and palm oils; a gentle, safe, skin-friendly, plant derived foaming cleanser.>, <9.00>, <http://ecx.images-amazon.com/images/I/21OS2EGxTgL._SL500_AA300_.jpg>, <011150224840>
        * When I click the create product link/button
        * Then I should see the created product
        * And I should see the correct product info
    * Scenario: Admin creates category
        * Given I click the add category link/button
        * And I fill in the field with <Personal Care>
        * Then I should see the new category with name <Personal Care>
    * Scenario: Admin adds product to category
        * Given I have created the product <Curls Patty Cake Baby Curl Conditioner>
        * And I have created the category <Personal Care>
        * When I edit the product <Curls Patty Cake Baby Curl Conditioner>
        * And I add it to the category <Personal Care>
        * And I browse to the category <Personal Care>
        * Then I should see the product <Curls Patty Cake Baby Curl Conditioner>
    * Scenario: Retiring a product
        * Given I am editing a product <Aquaphor Baby Gentle Wash> that has been purchased by "demo09+matt@jumpstartlab.com"
        * When I retire the product
        * And I log out
        * Then it should not show when browsing all products
