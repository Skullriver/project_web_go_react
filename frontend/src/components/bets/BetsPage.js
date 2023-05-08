import {Component} from "react";
import {format} from "date-fns";
import axios from "axios";
import {Button, Col, Container, Row} from "reactstrap";
import {RxUpdate} from "react-icons/rx";
import CreationModal from "./CreationModal";
import withAuth from "../auth/CheckAuth";
import {useNavigate} from "react-router-dom";

const withNavigate = (Component) => {
    return function WrappedComponent(props) {
        const navigate = useNavigate();
        return <Component navigate={navigate} {...props} />;
    }
};

class BetsPage extends Component {

    constructor(props) {
        super(props);
        this.state = {

        };
    }


    componentDidMount() {
        this.resetState();
    }

    resetState = () => {

    };

    handleExit = () => {
        localStorage.removeItem('token');
        this.props.navigate('/login');
    };

    render() {
        return (
            <div className="main-container">
                <Container fluid style={{marginTop: "15px", padding: "0 50px"}}>
                    <Row>
                        <Col>
                            <div>
                                <CreationModal/>
                            </div>
                            <button onClick={this.handleExit}>Exit</button>
                        </Col>
                    </Row>
                </Container>
            </div>
        );
    }
}

export default withAuth(withNavigate(BetsPage));