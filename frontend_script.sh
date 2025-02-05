#!/bin/bash

# Create the directory structure
mkdir -p my-app/frontend/{public,src,node_modules}

# Create Dockerfile
cat << 'EOF' > my-app/frontend/Dockerfile
FROM node:14

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

ENV NODE_ENV=development
ENV CHOKIDAR_USEPOLLING=true
ENV WATCHPACK_POLLING=true
ENV WDS_SOCKET_PORT=0

EXPOSE 3000

CMD ["npm", "start"]
EOF

# Create package.json
cat << 'EOF' > my-app/frontend/package.json
{
  "name": "frontend",
  "version": "0.1.0",
  "private": true,
  "dependencies": {
    "@testing-library/jest-dom": "^5.11.4",
    "@testing-library/react": "^11.1.0",
    "@testing-library/user-event": "^12.1.10",
    "axios": "^0.21.1",
    "react": "^17.0.2",
    "react-dom": "^17.0.2",
    "react-scripts": "4.0.3",
    "web-vitals": "^1.0.1"
  },
  "scripts": {
    "start": "DISABLE_ESLINT_PLUGIN=true react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "eslintConfig": {
    "extends": [
      "react-app"
    ]
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  },
  "proxy": "http://backend:5000"
}
EOF

# Create public/favicon.svg
cat << 'EOF' > my-app/frontend/public/favicon.svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <rect width="100" height="100" fill="#3498db"/>
  <text x="50" y="50" font-family="Arial" font-size="50" fill="white" text-anchor="middle" dominant-baseline="central">A</text>
</svg>
EOF

# Create public/index.html
cat << 'EOF' > my-app/frontend/public/index.html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <link rel="icon" href="%PUBLIC_URL%/favicon.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="theme-color" content="#000000" />
    <meta name="description" content="My App" />
    <link rel="apple-touch-icon" href="%PUBLIC_URL%/logo192.png" />
    <link rel="manifest" href="%PUBLIC_URL%/manifest.json" />
    <title>My App</title>
  </head>
  <body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root"></div>
  </body>
</html>
EOF

# Create public/manifest.json
cat << 'EOF' > my-app/frontend/public/manifest.json
{
  "short_name": "My App",
  "name": "My Application",
  "icons": [
    {
      "src": "favicon.ico",
      "sizes": "64x64 32x32 24x24 16x16",
      "type": "image/x-icon"
    },
    {
      "src": "logo192.png",
      "type": "image/png",
      "sizes": "192x192"
    }
  ],
  "start_url": ".",
  "display": "standalone",
  "theme_color": "#000000",
  "background_color": "#ffffff"
}
EOF

# Create src/App.js
cat << 'EOF' > my-app/frontend/src/App.js
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
EOF

# Create src/App.css
cat << 'EOF' > my-app/frontend/src/App.css
/* src/App.css */
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color: #f4f4f4;
  color: #333;
}

.app-container {
  max-width: 600px;
  margin: 50px auto;
  padding: 20px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.app-title {
  text-align: center;
  margin-bottom: 20px;
  color: #2c3e50;
}

.item-list {
  list-style: none;
  padding: 0;
  margin: 0 0 20px;
}

.item {
  background: #ecf0f1;
  margin-bottom: 10px;
  padding: 10px;
  border-radius: 4px;
  font-size: 16px;
  color: #34495e;
}

.input-container {
  display: flex;
  justify-content: space-between;
}

.input-field {
  width: 70%;
  padding: 10px;
  font-size: 16px;
  border: 1px solid #bdc3c7;
  border-radius: 4px;
}

.add-button {
  width: 25%;
  padding: 10px;
  font-size: 16px;
  background-color: #2ecc71;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.add-button:hover {
  background-color: #27ae60;
}
EOF

# Create src/index.css
cat << 'EOF' > my-app/frontend/src/index.css
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

code {
  font-family: source-code-pro, Menlo, Monaco, Consolas, 'Courier New',
    monospace;
}
EOF

# Create src/index.js
cat << 'EOF' > my-app/frontend/src/index.js
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);
EOF

echo "Frontend setup completed successfully!"
