import React from 'react';
import {NavLink} from "react-router-dom";

function Contact() {
    return (
        <div>
            <h1>this is the contact page</h1>
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

export default Contact;
