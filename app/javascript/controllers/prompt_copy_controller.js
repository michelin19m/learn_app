import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["title", "skill", "resource", "part"]

  copy() {
    const title = this.titleTarget.value.trim();
    const skill = this.skillTarget.value.trim();
    const resource = this.resourceTarget.value.trim();
    const part = this.partTarget.value.trim();

    if (!title || !skill || !resource || !part) {
      alert("Please provide all required details (Skill, Resource, Part, Test Title) to generate a prompt.");
      return;
    }

    const prompt = `
Skill: ${skill}
Resource: ${resource}
Part: ${part}
Test Title: ${title}

Please generate a series of questions and their correct answers based on the above details. The questions should comprehensively cover key concepts, definitions, and essential knowledge areas related to the specified topic. 

The output should be formatted as plain text suitable for CSV, with each question and answer separated by a comma. Ensure there are no additional commas in the question or answer texts. Use the following format:

question,answer
What is the capital of France?,Paris
What is the chemical symbol for water?,H2O
...

Please ensure the CSV content is correctly formatted and provides comprehensive coverage of the topic.

Thank you!`;

    navigator.clipboard.writeText(prompt).then(() => {
      alert('Prompt copied to clipboard!');
    }, (err) => {
      console.error('Failed to copy text: ', err);
    });
  }
}
