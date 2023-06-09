﻿@adoSpecific
Feature: Include synchronized Test Cases to a Test Suite

SpecSync can keep an ADO static Test Suite with the Test Cases synchronized 
from the scenarios.

Rule: Test Cases synchronized from scenarios should be added to the configured Test Suite

@tc:261
Scenario: Linked test cases are added to the Test Suite
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And there is a feature file in the local repository
		"""
		Feature: My Feature
		Scenario: Scenario 1
			When I do something
		Scenario: Scenario 2
			When I do something
		Scenario: Scenario 3
			When I do something
		"""
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	When the local repository is synchronized with push
	Then the command should succeed
	And the Test Suite should contain the following Test Cases
		| test case            |
		| Scenario: Scenario 1 |
		| Scenario: Scenario 2 |
		| Scenario: Scenario 3 |

@tc:262
Scenario: The Test Suite is specified with ID
	Given there is an Azure DevOps project with an empty Test Suite
	And there is a feature file in the local repository
		"""
		Feature: My Feature
		Scenario: Scenario 1
			When I do something
		"""
	And the synchronizer is configured to add test cases to test suite '#[id-of-test-suite]'
	When the local repository is synchronized with push
	Then the Test Suite should contain the following Test Cases
		| test case            |
		| Scenario: Scenario 1 |


Rule: Test Cases of deleted scenarios should be tagged and removed from the Test Suite during full synchronization

	full synchronization: in case there is a filter applied (e.g. --tagFilter), the Test Cases should not be removed

@tc:263
Scenario: The Test Case of a deleted scenario is removed from the Test Suite
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: My Feature

		@tc:[id-of-test-case]
		@sometag
		Scenario: Scenario 1
			When I do something
		"""
	When the feature file is updated to
		"""
		Feature: My Feature

		# Scenario 1 deleted
		"""
	And the local repository is synchronized with push
	Then the test suite should be empty
	And the Test Case should have the following tags: "sometag, specsync:removed"

@tc:264
Scenario: The removed tag is removed from the Test Case once it is reconnected
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: My Feature

		@tc:[id-of-test-case]
		@sometag
		Scenario: Scenario 1
			When I do something
		"""
	And the feature file was updated and synchronized as
		"""
		Feature: My Feature

		# Scenario 1 deleted
		"""
	When the feature file is updated to
		"""
		Feature: My Feature

		# Scenario 1 restored
		@tc:[id-of-test-case]
		@sometag
		Scenario: Scenario 1
			When I do something
		"""
	And the local repository is synchronized with push
	Then the Test Suite should contain the following Test Cases
		| test case            |
		| Scenario: Scenario 1 |
	And the Test Case should have the following tags: "sometag"

@tc:971
Scenario: In case of filtered synchronization the Test Case of a deleted scenario is not removed
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: My Feature

		@tc:[id-of-test-case]
		@sometag
		Scenario: Scenario 1
			When I do something
		"""
	And the synchronizer is provided with an option to filter scenario tags with "@some-filter"
	When the feature file is updated to
		"""
		Feature: My Feature

		# Scenario 1 deleted
		"""
	And the local repository is synchronized with push
	Then the Test Suite should contain the following Test Cases
		| test case            |
		| Scenario: Scenario 1 |



Rule: SpecSync should attempt to create the Test Suite if does not exist

@tc:972
@bypass-ado-integration
Scenario: A new Test Suite is configured
	Given there is an Azure DevOps project
	And there is a feature file in the local repository
		"""
		Feature: My Feature
		Scenario: Scenario 1
			When I do something
		"""
	And the synchronizer is configured to add test cases to test suite 'New Suite'
	When the local repository is synchronized with push
	Then the log should contain match "Test Suite scope 'New Suite' .* created."



Rule: Scope changes should be reflected in the Test Suite, while filter changes should not

Scope specifies the set of scenarios that are synchronized to ADO -- if a 
scenario is not in synchronization scope, it will not be added to the Test Suite.

Filtering is a way to temporarily synchronize only a subset of the scenarios --
the Test Suite will contain all scenarios, even if they are currently filtered out.

@tc:265
Scenario: Out-of-scope scenarios are removed from Test Suite
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: My Feature

		@tc:[id-of-test-case]
		@not_done
		Scenario: Scenario 1
			When I do something
		"""
	And the synchronizer is configured to scope scenarios tagged with "@done"
	When the local repository is synchronized with push
	Then the test suite should be empty

@tc:266
Scenario: Filtered out scenarios are not removed from Test Suite
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: My Feature

		@tc:[id-of-test-case]
		@done @not_interesting_now 
		Scenario: Scenario 1
			When I do something
		"""
	And the synchronizer is provided with an option to filter scenario tags with "@interesting"
	And the synchronizer is configured to scope scenarios tagged with "@done"
	When the local repository is synchronized with push
	Then the Test Suite should contain the following Test Cases
		| test case            |
		| Scenario: Scenario 1 |
