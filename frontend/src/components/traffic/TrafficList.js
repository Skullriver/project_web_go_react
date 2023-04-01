import {Component} from "react";
import {ReactComponent as RerLogo} from '../../RERicon.svg';
import {ReactComponent as MetroLogo} from '../../MetroIcon.svg';
import {AccordionBody, AccordionHeader, AccordionItem, Spinner, Table, UncontrolledAccordion} from "reactstrap";
import CustomModal from "../utils/CustomModal";
import {ImWarning} from "react-icons/im";

class TrafficList extends Component {

    // constructor(props) {
    //     super(props);
    // }

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

    render() {
        let traffic = this.props.traffic;
        let defaultOpen;
        if (traffic && traffic.length > 0) {
            defaultOpen = traffic.reduce((acc, item) => {
                if (item.line.disruptions !== null && item.line.disruptions.length > 0) {
                    acc.push(item.line.id.toString());
                }
                return acc;
            }, []);
        } else {
            defaultOpen = [];
        }

        return (

            <div>
                {!traffic || traffic.length <= 0 ? (
                    <Spinner color="secondary" size="sm">
                        Loading...
                    </Spinner>
                ) : (
                    <UncontrolledAccordion defaultOpen={defaultOpen} stayOpen>
                        {traffic.map(item => (
                            <AccordionItem key={item.line.id}>
                                <AccordionHeader className="traffic-header" targetId={item.line.id.toString()}>
                                    <div className="accordion-icons">
                                        {item.line.physical_mode === "physical_mode:Metro" ?
                                            <MetroLogo className="logo"/> : <RerLogo className="logo"/>}
                                        {this.RoundIcon(item.line.color, item.line.text_color, item.line.code)}
                                    </div>
                                    <div className="accordion-title">
                                        <div className="accordion-title-text">
                                            <span>{item.line.physical_mode === "physical_mode:Metro" ? item.line.name : ""}</span>
                                            {item.line.disruptions !== null && item.line.disruptions.length > 0 ?
                                                (<span className="accordion-title-warnings">{item.line.disruptions.length}<ImWarning/></span>)
                                                : ""}
                                        </div>
                                        <span className="schedule">
                                            <b>{item.line.opening_time}-{item.line.closing_time}</b>
                                        </span>
                                    </div>
                                </AccordionHeader>
                                <AccordionBody accordionId={item.line.id.toString()}>
                                    <Table responsive size="sm">
                                        <tbody>
                                        {item.line.disruptions !== null && item.line.disruptions.length > 0 ?
                                            (
                                                item.line.disruptions.map(disruption => (
                                                    <tr key={disruption.id}>
                                                        <td> {disruption.created_at}</td>
                                                        <td> {disruption.message.title} </td>
                                                        <td>
                                                            <CustomModal message={disruption.message.description}/>
                                                        </td>
                                                        <td>Updated: {disruption.updated_at}</td>
                                                    </tr>
                                                ))
                                            ) : <tr></tr>}
                                        </tbody>
                                    </Table>
                                </AccordionBody>
                            </AccordionItem>
                        ))}
                    </UncontrolledAccordion>
                )}
            </div>
        );
    }

}

export default TrafficList;