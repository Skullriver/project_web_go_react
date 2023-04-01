import {Component} from "react";
import {format} from "date-fns";
import '../../styles/trafficLog.css';
import axios from "axios";
import TrafficList from "./TrafficList";
import {Button, Col, Container, Row} from "reactstrap";
import CalendarApp from "../utils/Calendar";
import {RxUpdate} from "react-icons/rx";

let endpoint = "http://localhost:8080/api/traffic"

class TrafficPage extends Component {

    constructor(props) {
        super(props);
        this.state = {
            linesList: [],
            currentStartDate: format(new Date(), 'ddMMyyyy'),
            currentEndDate: format(new Date(), 'ddMMyyyy')
        };
    }


    componentDidMount() {
        this.resetState();
    }

    getTraffic = () => {
        this.setState({
            linesList: [],
        });
        const params = {
            dateStart: this.state.currentStartDate,
            dateEnd: this.state.currentEndDate
        };
        axios.get(endpoint, {params}).then(
            res => this.setState({
                linesList: res.data,
            })
        );
    };

    changeDate = dates => {
        if(dates[0] !== null && dates[1] !== null){
            this.setState({
                currentStartDate: format(dates[0], 'ddMMyyyy'),
                currentEndDate: format(dates[1], 'ddMMyyyy')
            })
        }

    }

    resetState = () => {
        this.getTraffic();
    };

    render() {
        let trafficList = this.state.linesList

        return (
            <div className="main-container">
                <div className="log-options">
                    <CalendarApp onChange={this.changeDate}/>
                    <div>
                        <Button onClick={this.resetState} outline={true} color="success">
                            <RxUpdate/>
                            Update
                        </Button>
                    </div>
                </div>
                <Container fluid style={{marginTop: "15px", padding: "0 50px"}}>
                    <Row>
                        <Col>
                            <TrafficList
                                traffic={trafficList}
                                resetState={this.resetState}
                            />
                        </Col>
                    </Row>
                </Container>
            </div>
        );
    }
}

export default TrafficPage;