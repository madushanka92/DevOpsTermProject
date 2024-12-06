import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import AddNumbers from "./AddNumbers"; // Adjust the import based on your file structure

describe("AddNumbers Component", () => {
  test("renders the component with inputs and buttons", () => {
    render(<AddNumbers />);

    // Check if inputs for numbers are present (now using spinbutton role)
    expect(
      screen.getByRole("spinbutton", { name: /Number 1/ })
    ).toBeInTheDocument();
    expect(
      screen.getByRole("spinbutton", { name: /Number 2/ })
    ).toBeInTheDocument();

    // Check if buttons are present
    expect(screen.getByText("Add")).toBeInTheDocument();
    expect(screen.getByText("Clear")).toBeInTheDocument();

    // Check if result is not displayed initially
    expect(screen.queryByText(/Result:/)).toBeNull();
  });

  test("adds numbers correctly", async () => {
    render(<AddNumbers />);

    // Find the input fields and buttons
    const num1Input = screen.getByLabelText(/Number 1/i);
    const num2Input = screen.getByLabelText(/Number 2/i);
    const addButton = screen.getByText("Add");

    // Set values for number inputs
    fireEvent.change(num1Input, { target: { value: "5" } });
    fireEvent.change(num2Input, { target: { value: "10" } });

    // Click the "Add" button
    fireEvent.click(addButton);

    // Wait for the result to appear
    await waitFor(() => screen.getByText(/Result: 15/i));

    // Check if the result is displayed
    expect(screen.getByText(/Result: 15/i)).toBeInTheDocument();
  });

  test("clears the input fields and result", async () => {
    render(<AddNumbers />);

    // Find the input fields, buttons, and result element
    const num1Input = screen.getByLabelText(/Number 1/i);
    const num2Input = screen.getByLabelText(/Number 2/i);
    const addButton = screen.getByText("Add");
    const clearButton = screen.getByText("Clear");

    // Set values for the input fields
    fireEvent.change(num1Input, { target: { value: "8" } });
    fireEvent.change(num2Input, { target: { value: "7" } });

    // Click the "Add" button
    fireEvent.click(addButton);

    // Wait for the result to appear
    await waitFor(() => screen.getByText(/Result: 15/i));

    // Check if the result is displayed
    expect(screen.getByText(/Result: 15/i)).toBeInTheDocument();

    // Click the "Clear" button
    fireEvent.click(clearButton);

    console.log("num1Input.value ", num1Input.value);

    // Check that the input fields are cleared
    expect(num1Input.value).toBe("0");
    expect(num2Input.value).toBe("0");

    // Check that the result is cleared
    expect(screen.queryByText(/Result: 15/i)).not.toBeInTheDocument();
  });
});
