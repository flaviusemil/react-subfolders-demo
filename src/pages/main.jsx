import {createBrowserRouter} from "react-router-dom";
import Home from "./Home";
import Contact from "./Contact";
import App from "../App";

const router = createBrowserRouter([
    {
        path: "/",
        element: <Home />
    },
    {
        path: "/contact",
        element: <Contact />
    },
    {
        path: "/default",
        element: <App />
    }
], {
    basename: "/"
});

export default router;
