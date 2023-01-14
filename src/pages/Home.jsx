import React from 'react';
import {NavLink} from "react-router-dom";
import Contact from "./Contact";

function Home() {
    return (
        <div>
            <h1>this is the home page</h1>
            <nav>
                <ul>
                    <li>
                        <NavLink to="/">Home</NavLink>
                    </li>
                    <li>
                        <NavLink to="/contact">Contact</NavLink>
                    </li>
                    <li>
                        <NavLink to="/default">Default</NavLink>
                    </li>
                </ul>
            </nav>
        </div>
    );
}

export default Home;
