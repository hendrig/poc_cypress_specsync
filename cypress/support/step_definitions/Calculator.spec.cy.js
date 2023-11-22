import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";
import { ordinal } from "../../support/common/parameters";

let first;
let second;
let third;
Given("que eu adicionei o número {ordinal}", (num) => {
  first = num;
  console.log(first);
});

Given("que eu adicionei o segundo número {ordinal}", (num) => {
  second = num;
  console.log(second);
});

When("eu somar", () => {
  third = first + second;
});

Then("o resultado deverá ser {ordinal}", (num) => {
  assert.deepEqual(third, num);
});
