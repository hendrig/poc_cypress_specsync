import { defineParameterType } from "@badeball/cypress-cucumber-preprocessor";

defineParameterType({
  name: "ordinal",
  regexp: /(\d+)/,
  transformer: (s) => parseInt(s, 10),
});
