class FlexMessageBuilder
  def initialize(cost)
    @cost = cost
  end

  def build
    message = {
      "type": "bubble",
      "body": {
        "type": "box",
        "layout": "vertical",
        "contents": [
          {
            "type": "box",
            "layout": "horizontal",
            "contents": [
              {
                "type": "text",
                "text": "合計",
                "size": "xl",
                "align": "start",
                "gravity": "center"
              },
              {
                "type": "text",
                "text": "#{@cost.total_amount}円",
                "size": "xl",
                "weight": "bold",
                "align": "end",
                "gravity": "center",
              }
            ]
          },
          {
            "type": "separator",
            "margin": "xxl"
          },
          {
            "type": "text",
            "text": "内訳",
            "size": "xs",
            "color": "#aaaaaa",
            "wrap": true
          },
          {
            "type": "box",
            "layout": "vertical",
            "margin": "xxl",
            "spacing": "sm",
            "contents": [
              {
                "type": "box",
                "layout": "horizontal",
                "contents": [
                  {
                    "type": "text",
                    "text": "ガソリン代金",
                    "size": "lg",
                    "color": "#555555",
                    "flex": 0
                  },
                  {
                    "type": "text",
                    "text": "#{@cost.gasoline_cost}円",
                    "size": "lg",
                    "color": "#111111",
                    "align": "end"
                  }
                ]
              },
              {
                "type": "box",
                "layout": "horizontal",
                "contents": [
                  {
                    "type": "text",
                    "text": "燃費",
                    "size": "sm",
                    "color": "#555555",
                    "flex": 0
                  },
                  {
                    "type": "text",
                    "text": "#{@cost.fuel_efficiency}km/L",
                    "size": "sm",
                    "color": "#111111",
                    "align": "end"
                  }
                ]
              },
              {
                "type": "box",
                "layout": "horizontal",
                "contents": [
                  {
                    "type": "text",
                    "text": "距離",
                    "size": "sm",
                    "color": "#555555",
                    "flex": 0
                  },
                  {
                    "type": "text",
                    "text": "#{@cost.distance}km",
                    "size": "sm",
                    "color": "#111111",
                    "align": "end"
                  }
                ]
              },
              {
                "type": "box",
                "layout": "horizontal",
                "contents": [
                  {
                    "type": "text",
                    "text": "ガソリン単価",
                    "size": "sm",
                    "color": "#555555"
                  },
                  {
                    "type": "text",
                    "text": "#{@cost.price_per_liter}円/L",
                    "align": "end"
                  }
                ]
              },
              {
                "type": "separator",
                "margin": "xxl"
              },
              {
                "type": "box",
                "layout": "horizontal",
                "margin": "xxl",
                "contents": [
                  {
                    "type": "text",
                    "text": "高速料金",
                    "size": "lg",
                    "color": "#555555"
                  },
                  {
                    "type": "text",
                    "text": "#{@cost.highway_cost}円",
                    "size": "lg",
                    "color": "#111111",
                    "align": "end"
                  }
                ]
              },
              {
                "type": "box",
                "layout": "horizontal",
                "contents": [
                  {
                    "type": "text",
                    "text": "出発IC",
                    "size": "sm",
                    "color": "#555555"
                  },
                  {
                    "type": "text",
                    "text": "#{@cost.start_place}",
                    "size": "sm",
                    "color": "#111111",
                    "align": "end"
                  }
                ]
              },
              {
                "type": "box",
                "layout": "horizontal",
                "contents": [
                  {
                    "type": "text",
                    "text": "到着IC",
                    "size": "sm",
                    "color": "#555555"
                  },
                  {
                    "type": "text",
                    "text": "#{@cost.arrive_place}",
                    "size": "sm",
                    "color": "#111111",
                    "align": "end"
                  }
                ]
              }
            ]
          },
          {
            "type": "separator",
            "margin": "xxl"
          }
        ],
        "spacing": "none",
        "margin": "none"
      },
      "styles": {
        "footer": {
          "separator": true
        }
      }
    }
    
    if @cost.extra_costs&.any?
      @cost.extra_costs.each do |extra_cost|
        extra_cost_box = {
          "type": "box",
          "layout": "horizontal",
          "contents": [
            {
              "type": "text",
              "text": "#{extra_cost.category}",
              "size": "md",
              "margin": "none"
            },
            {
              "type": "text",
              "text": "#{extra_cost.amount}円",
              "align": "end",
              "contents": [
                {
                  "type": "span",
                  "text": "#{extra_cost.amount}",
                  "size": "lg"
                },
                {
                  "type": "span",
                  "text": "円",
                  "size": "sm"
                }
              ]
            }
          ],
          "spacing": "none",
          "margin": "none"
        }
        #追加費用が存在する場合extra_cost_box を message[:body][:contents] 配列に追加
        message[:body][:contents].push(extra_cost_box)
      end
    end
    return flex_message = {
      "type": "flex",
      "altText": 'メッセージを送信しました',
      "contents": message
    }
  end
end
