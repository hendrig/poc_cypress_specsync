import { defineParameterType } from "@badeball/cypress-cucumber-preprocessor";

export const notes = ["A", "B", "C", "D", "E", "F", "G"];

defineParameterType({
  name: "note",
  regexp: new RegExp(notes.join("|")),
  transformer: (n) => n,
});

defineParameterType({
  name: "ordinal",
  regexp: /(\d+)/,
  transformer: (s) => parseInt(s, 10),
});
