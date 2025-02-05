import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css'; // Import custom styles

function App() {
  const [items, setItems] = useState([]);
  const [newItem, setNewItem] = useState('');

  useEffect(() => {
    axios.get('/items')
      .then(response => setItems(response.data));
  }, []);

  const addItem = () => {
    if (newItem.trim() === '') return; // Prevent adding empty items
    axios.post('/items', { name: newItem })
      .then(response => {
        setItems([...items, response.data]);
        setNewItem('');
      });
  };

  return (
    <div className="app-container">
      <h1 className="app-title">Todo List</h1>
      <ul className="item-list">
        {items.map(item => (
          <li key={item.id} className="item">
            {item.name}
          </li>
        ))}
      </ul>
      <div className="input-container">
        <input
          type="text"
          value={newItem}
          onChange={e => setNewItem(e.target.value)}
          className="input-field"
          placeholder="Add new item"
        />
        <button onClick={addItem} className="add-button">
          Add Item
        </button>
      </div>
    </div>
  );
}

export default App;
