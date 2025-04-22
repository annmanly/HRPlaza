--!AddComponentMenu("")

-- LocalizedValue
type LocalizedValue =
{
}

-- LocalizedValueType
type LocalizedValueType =
{
    DayAndMonth: (time: number) -> string,
    DayAndMonthAndFullYear: (time: number) -> string,
    DayAndMonthAndYear: (time: number) -> string,
    HoursMinutes: (duration: number) -> string,
    HoursMinutesSeconds: (duration: number) -> string,
    MonthAndYear: (time: number, abbreviated: boolean?) -> string,
    Numeric: (value: number, decimalPoints: number?, abbreviated: boolean?) -> string,
    TimeAgo: (time: number, shortForm: boolean?) -> string,
    TimeIn: (time: number, shortForm: boolean?) -> string,
    TimeLeft: (secondsLeft: number) -> string,
    TimeSpan: (seconds: number) -> string,
    __tostring: () -> string,
}

if not _G.LocalizedValue then
    local LocalizedValueType_instance : LocalizedValueType = {}
    _G.LocalizedValue = LocalizedValueType_instance;
end
