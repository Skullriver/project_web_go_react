import {AccordionBody, AccordionHeader, AccordionItem, Spinner, UncontrolledAccordion} from "reactstrap";
import {Component} from "react";
import '../../styles/trafficLog.css';
import axios from "axios";
import {ReactComponent as RerLogo} from '../../RERicon.svg';
import {ReactComponent as MetroLogo} from '../../MetroIcon.svg';

let endpoint = "http://localhost:8080/api/traffic"

class TrafficLog extends Component {

    constructor(props) {
        super(props);
        this.state = {
            linesList: [],
        };
    }

    RoundIcon(backgroundColor, textColor, children) {
        const iconStyle = {
            backgroundColor: backgroundColor,
            color: textColor,
        };

        return (
            <div className="round-icon" style={iconStyle}>
                {children}
            </div>
        );
    }


    componentDidMount() {
        this.resetState();
    }

    getTrafficLog = () => {
        axios.get(endpoint).then(
            res => this.setState({
                linesList: res.data,
            })
        );
    };

    resetState = () => {
        this.getTrafficLog();
    };

    render() {
        let defaultOpen;
        if (this.state.linesList && this.state.linesList.length > 0) {
            defaultOpen = this.state.linesList.map((item) => item.line.id.toString());
        } else {
            defaultOpen = [];
        }
        return (
            <div className="accordion">
                {!this.state.linesList || this.state.linesList.length <= 0 ? (
                    <Spinner color="secondary" size="sm">
                        Loading...
                    </Spinner>
                ) : (
                    <UncontrolledAccordion defaultOpen={defaultOpen} stayOpen>
                        {this.state.linesList.map(item => (
                            <AccordionItem key={item.line.id}>
                                <AccordionHeader className="traffic-header" targetId={item.line.id.toString()}>
                                    {item.line.physical_mode === "physical_mode:Metro" ?
                                        <MetroLogo className="logo"/> : <RerLogo className="logo"/>}
                                    {this.RoundIcon(item.line.color, item.line.text_color, item.line.code)}
                                    {item.line.physical_mode === "physical_mode:Metro" ? item.line.name : ""}
                                    <span className="schedule">
                                        <b>{item.line.opening_time}-{item.line.closing_time}</b>
                                    </span>
                                </AccordionHeader>
                                <AccordionBody accordionId={item.line.id.toString()}>
                                    {item.line.disruptions !== null && item.line.disruptions.length > 0 ?
                                        (
                                            item.line.disruptions.map(disruption => (
                                                <div key={disruption.id}>
                                                    <p>Title: {disruption.message.title}</p>
                                                    <div dangerouslySetInnerHTML={{__html: disruption.message.description}} />
                                                    <p>Updated At: {disruption.updated_at}</p>
                                                    <p>Application Start: {disruption.application_start}</p>
                                                    <p>Application End: {disruption.application_end}</p>
                                                    <hr/>
                                                </div>
                                            ))
                                        ) : <div></div>}
                                </AccordionBody>
                            </AccordionItem>
                        ))}
                    </UncontrolledAccordion>
                )}
            </div>
        );
    }
}

export default TrafficLog;