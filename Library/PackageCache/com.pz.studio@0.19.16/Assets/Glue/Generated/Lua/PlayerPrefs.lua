--!AddComponentMenu("")

-- PlayerPrefs
type PlayerPrefs =
{
}

-- PlayerPrefsType
type PlayerPrefsType =
{
    DeleteKey: (key: string) -> (),
    GetFloat: (key: string, defaultValue: number?) -> number,
    GetInt: (key: string, defaultValue: number?) -> number,
    GetString: (key: string, defaultValue: string?) -> string,
    HasKey: (key: string) -> boolean,
    SetFloat: (key: string, value: number) -> (),
    SetInt: (key: string, value: number) -> (),
    SetString: (key: string, value: string) -> (),
    __tostring: () -> string,
}

if not _G.PlayerPrefs then
    local PlayerPrefsType_instance : PlayerPrefsType = {}
    _G.PlayerPrefs = PlayerPrefsType_instance;
end
