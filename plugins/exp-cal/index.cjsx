path = require 'path-extra'
{relative, join} = require 'path-extra'
{$, _, $$, Reat, ReactBootstrap, ROOT} = window
{_ships, $ships, $shipTypes} = window
{Grid, Col, Input, DropdownButton, MenuItem, Button} = ReactBootstrap
exp = [
  0, 0, 100, 300, 600, 1000, 1500, 2100, 2800, 3600,
  4500, 5500, 6600, 7800, 9100, 10500, 12000, 13600, 15300, 17100,
  19000, 21000, 23100, 25300, 27600, 30000, 32500, 35100, 37800, 40600,
  43500, 46500, 49600, 52800, 56100, 59500, 63000, 66600, 70300, 74100,
  78000, 82000, 86100, 90300, 94600, 99000, 103500, 108100, 112800, 117600,
  122500, 127500, 132700, 138100, 143700, 149500, 155500, 161700, 168100, 174700,
  181500, 188500, 195800, 203400, 211300, 219500, 228000, 236800, 245900, 255300,
  265000, 275000, 285400, 296200, 307400, 319000, 331000, 343400, 356200, 369400,
  383000, 397000, 411500, 426500, 442000, 458000, 474500, 491500, 509000, 527000,
  545500, 564500, 584500, 606500, 631500, 661500, 701500, 761500, 851500, 1000000,
  1000000, 1010000, 1011000, 1013000, 1016000, 1020000, 1025000, 1031000, 1038000, 1046000,
  1055000, 1065000, 1077000, 1091000, 1107000, 1125000, 1145000, 1168000, 1194000, 1223000,
  1255000, 1290000, 1329000, 1372000, 1419000, 1470000, 1525000, 1584000, 1647000, 1714000,
  1785000, 1860000, 1940000, 2025000, 2115000, 2210000, 2310000, 2415000, 2525000, 2640000,
  2760000, 2887000, 3021000, 3162000, 3310000, 3465000, 3628000, 3799000, 3978000, 4165000,
  4360000, 4360000
]
expValue = [
  30, 50, 80, 100, 150, 50,
  120, 150, 200, 300, 250,
  310, 320, 330, 350, 400,
  310, 320, 330, 340,
  360, 380, 400, 420, 450,
  380, 420
]
expPercent = [
  1.2, 1.0, 1.0, 0.8, 0.7
]
expLevel = [
  "S", "A", "B", "C", "D"
]
expMap = [
  "1-1 鎮守府正面海域", "1-2 南西諸島沖", "1-3 製油所地帯沿岸", "1-4 南西諸島防衛線", "1-5 [Extra] 鎮守府近海", "1-6 [Extra Operation] 鎮守府近海航路",
  "2-1 カムラン半島", "2-2 バシー島沖", "2-3 東部オリョール海", "2-4 沖ノ島海域", "2-5 [Extra] 沖ノ島沖",
  "3-1 モーレイ海", "3-2 キス島沖", "3-3 アルフォンシーノ方面", "3-4 北方海域全域", "3-5 [Extra] 北方AL海域",
  "4-1 ジャム島攻略作戦", "4-2 カレー洋制圧戦", "4-3 リランカ島空襲", "4-4 カスガダマ沖海戦",
  "5-1 南方海域前面", "5-2 珊瑚諸島沖", "5-3 サブ島沖海域", "5-4 サーモン海域", "5-5 [Extra] サーモン海域北方",
  "6-1 中部海域哨戒線", "6-2 MS諸島沖"
]

module.exports =
  name: 'ExpCalView'
  priority: 2
  displayName: '经验值计算'
  description: '计算经验值概览界面'
  reactClass: React.createClass
    getInitialState: ->
      _ships: null
      currentLevel: null
      nextExp: null
      goalLevel: null
      mapValue: null
      mapPercent: null
      shipId: null
    handleShipChange: (e) ->
      alert @state._ships[e.target.value].api_lv
      alert @state._ships[e.target.value].api_lv > 99
      if @state._ships[e.target.value].api_lv > 99
        nextLv = 150
      else
        nextLv = 99
      alert nextLv
      nextLv = Math.min nextLv, $ships[@state._ships[e.target.value].api_ship_id].api_afterlv
      curLevel = @state._ships[e.target.value].api_lv
      nxtExp = @state._ships[e.target.value].api_exp[1]
      alert curLevel
      alert nxtExp
      alert nextLv
      @setState
        currentLevel: curLevel
        nextExp: nxtExp
        goalLevel: nextLv
    handleExpLevelChange: (e) ->
      @setState
        mapPercent: e.target.value
    handleExpMapChange: (e) ->
      @setState
        mapValue: e.target.value
    handleCurrentLevelChange: (e) ->
      @setState
        currentLevel: e.target.value
    handleNextExpChange: (e) ->
      @setState
        nextExp: e.target.value
    handleGoalLevelChange: (e) ->
      @setState
        goalLevel: e.target.value
    handleResponse: (e) ->
      {method, path, body, postBody} = e.detail
      switch path
        when '/kcsapi/api_port/port'
          @setState
            _ships: window._ships
    componentDidMount: ->
      window.addEventListener 'game.response', @handleResponse
    render: ->
      <div>
        <link rel="stylesheet" href={join(relative(ROOT, __dirname), 'assets', 'exp-cal.css')} />
        <Grid>
          <Col xs={5}>
            <Input type="select" label="舰娘" onChange={@handleShipChange}>
            {
              {$ships, $shipTypes} = window
              if @state._ships
                for ship, i in @state._ships
                  continue unless ship?
                  shipInfo = $ships[ship.api_ship_id]
                  <option key={i} value={i}>{shipInfo.api_name}({ship.api_lv})</option>
              else
                <option key={0}>NULL</option>
            }
            </Input>
          </Col>
          <Col xs={5}>
            <Input type="select" label="海域" placeholder="3-2 キス島沖" onChange={@handleExpMapChange}>
            {
              for x, i in expMap
                <option key={i} value={expValue[i]}>{x}</option>
            }
            </Input>
          </Col>
          <Col xs={2}>
            <Input type="select" label="评价" placeholder="S" onChange={@handleExpLevelChange}>
            {
              for x, i in expLevel
                <option key={i} value={expPercent[i]}>{x}</option>
            }
            </Input>
          </Col>
          <Col xs={4}>
          {
            currentLevel = @state.currentLevel
            <Input type="text" label="等级信息" placeholder="目前等级" value={currentLevel unless currentLevel?} onChange={@handleCurrentLevelChange} />
          }
          </Col>
          <Col xs={4}>
          {
            nextExp = @state.nextExp
            <Input type="text" label="　" placeholder="距离下一级" value={nextExp unless nextExp?} onChange={@handleNextExpChange}/>
          }
          </Col>
          <Col xs={4}>
          {
            goalLevel = @state.goalLevel
            <Input type="text" label="　" placeholder="目标等级" value={goalLevel unless goalLevel?} onChange={@handleGoalLevelChange}/>
          }
          </Col>
        </Grid>

      </div>
