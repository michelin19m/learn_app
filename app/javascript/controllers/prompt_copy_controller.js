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

Please generate a series of multiple-choice questions with four answer options each. Ensure that there is only one correct answer per question.

The output should be formatted as plain text suitable for CSV, with each question followed by four answer options and the correct answer clearly indicated. Use the following format:

question,answer1,answer2,answer3,answer4,correct_answer

**Important Formatting Guidelines**:
1. **Avoid Commas and Quotation Marks**: Do not include commas or quotation marks in the questions or answers, as these can interfere with the CSV format.
2. **Exact Match**: Ensure that the correct answer is an exact match to one of the provided answer options.
3. **Use Plain Language**: Simplify complex terms or phrases that might require special characters.

Example:
question,answer1,answer2,answer3,answer4,correct_answer
What is the capital of France?,Paris,Berlin,Rome,Madrid,Paris
What is the chemical symbol for water?,H2O,CO2,O2,H2,H2O

Please ensure clarity and consistency in the output. Thank you!`;

    navigator.clipboard.writeText(prompt).then(() => {
      alert('Prompt copied to clipboard!');
    }, (err) => {
      console.error('Failed to copy text: ', err);
    });
  }
}
