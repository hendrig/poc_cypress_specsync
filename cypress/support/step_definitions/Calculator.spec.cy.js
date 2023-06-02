import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";
import { ordinal } from "../../support/common/parameters";

let first;
let second;
let third;
Given("I have entered {ordinal} into the calculator", (num) => {
  first = num;
  console.log(first);
});

Given("then I have entered {ordinal} into the calculator", (num) => {
  second = num;
  console.log(second);
});

When("I choose add", () => {
  third = first + second;
});

Then("the result should be {ordinal}", (num) => {
  assert.deepEqual(third, num);
});
