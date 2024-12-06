import React, { useState } from "react";
import "./AddNumbers.css";

const AddNumbers = () => {
  const [num1, setNum1] = useState(0);
  const [num2, setNum2] = useState(0);
  const [result, setResult] = useState(null);

  const handleAddition = () => {
    setResult(num1 + num2);
  };

  const handleClear = () => {
    setNum1(0);
    setNum2(0);
    setResult(null);
  };

  return (
    <div className="add-numbers">
      <h2>Add Two Numbers</h2>
      <div className="numbers">
        <div className="number1">
          <label htmlFor="num1">Number 1</label>
          <input
            id="num1"
            type="number"
            value={num1}
            onChange={(e) => setNum1(Number(e.target.value))}
          />
        </div>
        <div className="number1">
          <label htmlFor="num2">Number 2</label>
          <input
            id="num2"
            type="number"
            value={num2}
            onChange={(e) => setNum2(Number(e.target.value))}
          />
        </div>
      </div>
      <div className="buttons">
        <button onClick={handleAddition}>Add</button>
        <button onClick={handleClear}>Clear</button>
      </div>
      {result !== null && <p>Result: {result}</p>}
    </div>
  );
};

export default AddNumbers;
