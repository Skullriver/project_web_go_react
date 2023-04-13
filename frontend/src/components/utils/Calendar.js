import React, {forwardRef, useRef, useState} from "react";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import 'react-calendar/dist/Calendar.css';
import '../../styles/Calendar.css'
import {fr} from "date-fns/locale";
import {Button} from "reactstrap";
import {FaRegCalendarAlt} from "react-icons/fa";


function CalendarApp(props) {
    const [startDate, setStartDate] = useState(new Date());
    const [endDate, setEndDate] = useState(new Date());
    const handleDateChange = (dates) => {
        const [start, end] = dates;
        setStartDate(start);
        setEndDate(end);
        if (props.onChange) {
            props.onChange(dates);
        }
    }
    const CustomInput = React.forwardRef(({value, onClick}, ref) => (
        <Button className="react-datepicker-custom-input" onClick={onClick} innerRef={ref}
                color="primary"
                outline>
            <FaRegCalendarAlt />
            {value}
        </Button>
    ));

    return (
        <div>
            <DatePicker
                dateFormat="dd/MM/yyyy"
                selected={startDate}
                onChange={handleDateChange}
                startDate={startDate}
                endDate={endDate}
                selectsRange={true}
                customInput={<CustomInput/>}
                minDate={new Date(2023, 2, 31)}
                maxDate={new Date()} // will not allow date later than today
                locale={fr}
                todayButton="Today"
            />
        </div>
    );

}

export default CalendarApp;