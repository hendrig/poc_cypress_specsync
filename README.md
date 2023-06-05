# POC - SpecSync and Cypress

This is a Proof of Concept (POC) for the usage of [SpecSync](https://www.specsolutions.eu/specsync/) and [Cypress](https://www.cypress.io/).

The default project running Cypress was based on [this video](https://youtu.be/bboMTD-c2vc) by "Automation and Stuff by Bhadmus" on YouTube (thanks @bhadmusautomates. Your videos saved a lot of time and helped me to understand the Cypress basic configuration).

## ATDD Lifecycle

In order to run an ATDD like lifecycle you can do the following:

- Create a story on Azure DevOps. The Acceptance Criteria must have a rough sketch of what is expected by the story, writen in Gherkin
- Go to the repository with the test cases and add a Gherkin scenario for the story. After adding it, tag the test case with the user story id
- On the repository, run `npm run sync`. It will run the standalone version of SpecSync and will publish the tests on the Azure DevOps Test Management page
- After that, develop the code for the story.
- After the code being completly developed, run the tests using `npm run test`. Then, publish the results using the command `npm run sync:result`.
