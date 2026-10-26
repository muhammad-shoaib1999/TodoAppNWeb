import { NavLink } from "react-router-dom";

export default function Header() {
    return (
        <div className="navbar navbar-expand-lg bg-dark" data-bs-theme="dark">
            <div className="container">
                <a className="navbar-brand" href="#">Navbar</a>
                <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span className="navbar-toggler-icon"></span>
                </button>
                <div className="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul className="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li className="nav-item">
                            <NavLink to="/" className="nav-link"> All-Task </NavLink>
                        </li>
                        <li className="nav-item">
                            <NavLink to="add" className="nav-link"> Add Task </NavLink>
                        </li>
                    </ul>
                
                </div>
            </div>
        </div>
    )
}