import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import jwt_decode from 'jwt-decode';

const withAuth = (Component) => {
    const AuthenticatedComponent = (props) => {
        const navigate = useNavigate();

        useEffect(() => {
            const token = localStorage.getItem('token');

            try {
                const decodedToken = jwt_decode(token);
                if (!token || decodedToken.exp < Date.now() / 1000) {
                    // Redirect user to login page if no token is found
                    navigate('/login');
                }
            } catch (error) {
                navigate('/login', { state: { error: 'Your session has expired. Please log in again.' } });
            }
        }, [navigate]);

        return <Component {...props} />;
    };

    return AuthenticatedComponent;
};

export default withAuth;