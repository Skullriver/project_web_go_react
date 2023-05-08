import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import jwt_decode from 'jwt-decode';

const withAuth = (Component) => {
    const AuthenticatedComponent = (props) => {
        const navigate = useNavigate();
        useEffect(() => {
            // Get token from localStorage
            const token = localStorage.getItem('token');
            if (!token || jwt_decode(token).exp < Date.now() / 1000) {
                // Redirect user to login page if no token is found
                navigate('/login');
            }
        }, [navigate]);

        return <Component {...props} />;
    };

    return AuthenticatedComponent;
};

export default withAuth;