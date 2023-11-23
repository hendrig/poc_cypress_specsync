import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

let site;
let response;
Given("que eu digitei o endereço do site {}", (siteDigitado) => {
  site = siteDigitado;
});

When("eu iniciar a navegação", () => {
  cy.visit(site).then((data) => {
    response = data;
  });
});

Then("eu devo ter conseguido acessar o site", () => {
  expect(response).to.exist;
});
